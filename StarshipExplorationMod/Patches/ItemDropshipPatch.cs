using System;
using System.Collections.Generic;
using HarmonyLib;
using UnityEngine;
using StarshipDeliveryMod;

namespace StarshipExplorationMod.Patches
{
    [HarmonyPatch(typeof(ItemDropship))]
    internal class ItemDropshipPatch
    {
        [HarmonyPatch("Start")]
        [HarmonyPostfix]
        public static void StartPatch(ref ItemDropship __instance)
        {
            StarshipDelivery.InitStarshipReplacement(__instance);
            StarshipEditing.EditStarshipModel(__instance.gameObject);
        }
    }
}