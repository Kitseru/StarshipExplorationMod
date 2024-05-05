using System;
using System.Collections.Generic;
using HarmonyLib;
using UnityEngine;
using StarshipDeliveryMod;
using GameNetcodeStuff;

namespace StarshipExplorationMod.Patches
{
    [HarmonyPatch(typeof(PlayerControllerB))]
    public class PlayerControllerBPatch
    {
        [HarmonyPatch("Start")]
        [HarmonyPostfix]
        public static void StartPatch(ref PlayerControllerB __instance)
        {
            __instance.gameObject.AddComponent<PlayerStarshipExtras>();
        }

        [HarmonyPatch("UpdatePlayerPositionClientRpc")]
        [HarmonyPostfix]
        public static void UpdatePlayerPositionClientRpcPatch(ref PlayerControllerB __instance)
        {
            var playerExtra = __instance.GetComponent<PlayerStarshipExtras>();

            if(playerExtra.inStarshipElevator != playerExtra.wasInStarshipElevator)
            {
                playerExtra.wasInStarshipElevator = playerExtra.inStarshipElevator;

                if(!playerExtra.inStarshipElevator)
                {
                    StarshipExploration.mls.LogInfo("---> Not in elevator");
                    __instance.transform.SetParent(__instance.playersManager.playersContainer);
                }
                else
                {
                    StarshipExploration.mls.LogInfo("---> In elevator");
                    __instance.transform.SetParent(playerExtra.startshipElevatorTransform);
                }
            }
        }

        [HarmonyPatch("KillPlayerClientRpc")]
        [HarmonyPostfix]
        public static void KillPlayerClientRpcPatch(ref PlayerControllerB __instance, int playerId)
        {
            PlayerControllerB component = __instance.playersManager.allPlayerObjects[playerId].GetComponent<PlayerControllerB>();
            component?.transform.SetParent(__instance.playersManager.playersContainer);
        }
    }
}