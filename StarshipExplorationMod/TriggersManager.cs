using System;
using System.Collections.Generic;
using HarmonyLib;
using StarshipExplorationMod;
using UnityEngine;

namespace StarshipExplorationMod{   
    

internal class TriggersManager
{
    private static List<Renderer> triggerCollection = [];

    //Generic so any array type can be passed as argument as long as it's a component
    public static void AddToTriggerCollection<T>(T[] objects) where T : Component
    {
        foreach (var obj in objects)
        {
            var renderer = obj.GetComponent<Renderer>();

            if(renderer == null) continue;
            if(triggerCollection.Contains(renderer)) continue;

            triggerCollection.Add(renderer);
            renderer.enabled = false;
        }
    }
    public static void HideTriggers()
    {
        foreach(var renderer in triggerCollection)
        {
            renderer.enabled = false;
        }
    }
}


}