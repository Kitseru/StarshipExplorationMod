using System;
using System.Collections.Generic;
using HarmonyLib;
using UnityEngine;
using StarshipDeliveryMod;
using System.Reflection;
using System.Reflection.Emit;

namespace StarshipExplorationMod.Patches{


[HarmonyPatch(typeof(ItemDropship))]
public class ItemDropshipPatch
{
    [HarmonyPatch("Start")]
    [HarmonyPostfix]
    public static void StartPatch(ref ItemDropship __instance)
    {
        StarshipDelivery.InitStarshipReplacement(__instance);
        StarshipEditing.EditStarshipModel(__instance.gameObject);
        TriggersManager.HideTriggers();
    }

    [HarmonyPatch("ShipLeave")]
    [HarmonyPostfix]
    public static void ShipLeavePatch(ref ItemDropship __instance)
    {
        __instance.GetComponentInChildren<StarshipElevator>().ShipLeave();
    }

    [HarmonyPatch(typeof(ItemDropship), "Update")]
    static IEnumerable<CodeInstruction> Transpiler(IEnumerable<CodeInstruction> instructions, ILGenerator il)
    {
        var code = new List<CodeInstruction>(instructions);

        int insertionIndex = -1;
        Label timesPlayedWithoutTurningOff_Label = il.DefineLabel();
        Label noiseInterval_Label = il.DefineLabel();
        for (int i = 0; i < code.Count - 1; i++) // -1 since we will be checking i + 1
        {
            if(code[i].opcode == OpCodes.Ldc_I4_0 && code[i+1].opcode == OpCodes.Stfld && code[i+1].operand is FieldInfo fieldInfo_1 && fieldInfo_1.Name == "timesPlayedWithoutTurningOff")
            {
                StarshipExploration.mls.LogInfo("---------- ShipTimer Found !!!!!!! ---------- at line : " + i);
                code[i-1].labels.Add(timesPlayedWithoutTurningOff_Label);
                insertionIndex = i-1;
            }
            if(code[i].opcode == OpCodes.Ldfld && code[i].operand is FieldInfo fieldInfo_2 && fieldInfo_2.Name == "noiseInterval" && code[i+1].opcode == OpCodes.Ldc_R4)
            {
                StarshipExploration.mls.LogInfo("---------- NoiseInterval Found !!!!!!! ---------- at line : " + i);
                code[i-1].labels.Add(noiseInterval_Label);
            }
        }

        var customInstuctions = new List<CodeInstruction>();

        var logMethod = AccessTools.Method(typeof(UnityEngine.Debug), "Log", new Type[] { typeof(object) });

        //Log :
        //customInstuctions.Add(new CodeInstruction(OpCodes.Ldstr, "----------- Transpiler added code Begining"));
        //customInstuctions.Add(new CodeInstruction(OpCodes.Call, logMethod));

        customInstuctions.Add(new CodeInstruction(OpCodes.Ldarg_0));

        var isElevatorRetractedMethod = AccessTools.Method(typeof(ItemDropshipPatch), "isElevatorRetracted");
        customInstuctions.Add(new CodeInstruction(OpCodes.Call, isElevatorRetractedMethod));

        customInstuctions.Add(new CodeInstruction(OpCodes.Stloc_0));

        customInstuctions.Add(new CodeInstruction(OpCodes.Ldloc_0));

        customInstuctions.Add(new CodeInstruction(OpCodes.Brtrue_S, timesPlayedWithoutTurningOff_Label));

        customInstuctions.Add(new CodeInstruction(OpCodes.Ldarg_0));

        customInstuctions.Add(new CodeInstruction(OpCodes.Ldarg_0));

        var shipTimerField = AccessTools.Field(typeof(ItemDropship), "shipTimer");
        customInstuctions.Add(new CodeInstruction(OpCodes.Ldfld, shipTimerField));

        var getDeltaTimeMethod = AccessTools.Method(typeof(UnityEngine.Time), "get_deltaTime");
        customInstuctions.Add(new CodeInstruction(OpCodes.Call, getDeltaTimeMethod));

        customInstuctions.Add(new CodeInstruction(OpCodes.Sub));

        customInstuctions.Add(new CodeInstruction(OpCodes.Stfld, shipTimerField));

        //Log :
        //customInstuctions.Add(new CodeInstruction(OpCodes.Ldstr, "----------- Substracting DeltaTime"));
        //customInstuctions.Add(new CodeInstruction(OpCodes.Call, logMethod));

        customInstuctions.Add(new CodeInstruction(OpCodes.Br_S, noiseInterval_Label));

        StarshipExploration.mls.LogInfo("------------------- customInstructions : ");
        foreach (var instuction in customInstuctions)
        {
            StarshipExploration.mls.LogInfo(instuction.ToString());
        }

        if (insertionIndex != -1)
        {
            code.InsertRange(insertionIndex, customInstuctions);
            StarshipExploration.mls.LogInfo("------------------- Transpiler successifully inject new instructions");
        }
        return code;
    }

    public static bool isElevatorRetracted(ItemDropship _dropShip)
    {
        bool isElevatorRetracted = _dropShip.GetComponentInChildren<StarshipElevator>().isRetracted;
        return isElevatorRetracted;
    }        
}


}