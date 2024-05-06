using System;
using System.Collections.Generic;
using UnityEngine;
using BepInEx;
using BepInEx.Logging;
using HarmonyLib;
using System.IO;
using System.Reflection;
using StarshipDeliveryMod;
using StarshipExplorationMod.Patches;

namespace StarshipExplorationMod{


[BepInPlugin(MyPluginInfo.PLUGIN_GUID, MyPluginInfo.PLUGIN_NAME, MyPluginInfo.PLUGIN_VERSION)]
[BepInDependency("Laventin.StarshipDeliveryMod", BepInDependency.DependencyFlags.HardDependency)]
[BepInDependency(LethalLib.Plugin.ModGUID)] 
public class StarshipExploration : BaseUnityPlugin
{
    private readonly Harmony harmony = new(MyPluginInfo.PLUGIN_GUID);

    internal static StarshipExploration Instance = null!;

    internal static ManualLogSource mls = null!;

    public static AssetBundle Ressources = null!;

    void Awake()
    {
        if (Instance == null)
        {
            Instance = this;
        }

        mls = BepInEx.Logging.Logger.CreateLogSource(MyPluginInfo.PLUGIN_GUID);
        mls.LogInfo("Starship Exploration Mod loaded");

        string currentAssemblyLocation = Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location);

        Ressources = AssetBundle.LoadFromFile(Path.Combine(currentAssemblyLocation, "starshipexploration"));

        if (Ressources == null) {
            mls.LogError("Failed to load custom assets.");
            return;
        }

        StarshipDelivery.AutoReplace = false;

        harmony.PatchAll(typeof(ItemDropshipPatch));
        harmony.PatchAll(typeof(PlayerControllerBPatch));

        //LethalLib.Modules.NetworkPrefabs.RegisterNetworkPrefab(bigRedButtonPrefab);

        mls = Logger;
    }
}


}

//Utils :

//Fog around player : 
//Systems/Rendering/VolumeMain