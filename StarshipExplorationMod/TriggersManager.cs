using System;
using System.Collections.Generic;
using HarmonyLib;
using StarshipExplorationMod;
using UnityEngine;

namespace StarshipExplorationMod
{
    internal class TriggersManager
    {
        private static List<Renderer> triggerCollection = [];

        public static void AddToTriggerCollection(GameObject[] _triggers)
        {
            foreach (var trigger in _triggers)
            {
                if(triggerCollection.Contains(trigger.GetComponent<Renderer>()))
                {
                    continue;
                }
                
                triggerCollection.Add(trigger.GetComponent<Renderer>());
            }

            HideTriggers();
        }

        public static void HideTriggers()
        {
            foreach (var trigger in triggerCollection)
            {
                trigger.enabled = false;
            }
        }
    }
}