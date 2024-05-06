using System;
using System.Collections.Generic;
using StarshipExplorationMod;
using UnityEngine;

namespace StarshipExplorationMod{

/// <summary>
/// This class allows to find specific originals Assets from the game.
/// </summary>
internal static class AssetFinder
{
    private static Sprite? handInteractIcon;
    private static AudioClip? buttonAudioClip;

    public static Sprite? GetHandInteractIcon()
    {
        if(handInteractIcon == null)
        {
            Sprite icon = GameObject.Find("Environment/HangarShip/AnimatedShipDoor/HangarDoorButtonPanel/StartButton/Cube (2)").GetComponent<InteractTrigger>().hoverIcon;

            if(icon == null) return null;

            return icon;
        }

        return handInteractIcon;
    }

    public static AudioClip? GetButtonAudioClip()
    {
        if(handInteractIcon == null)
        {
            AudioClip clip = GameObject.Find("Environment/HangarShip/AnimatedShipDoor/HangarDoorButtonPanel/StartButton/Cube (2)").GetComponent<AnimatedObjectTrigger>().boolFalseAudios[0];

            if(clip == null) return null;

            return clip;
        }

        return buttonAudioClip;
    }
}


}