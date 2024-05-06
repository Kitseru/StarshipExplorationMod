using System;
using System.Collections;
using GameNetcodeStuff;
using UnityEngine;

namespace StarshipExplorationMod{


internal class StarshipElevatorButton : MonoBehaviour
{
    public Action? onButtonPressed;
    private InteractTrigger? trigger;
    private AudioClip? buttonSound;

    void Start()
    {
        trigger = this.GetComponent<InteractTrigger>();
        trigger.onInteract.AddListener(OnTriggerInteract);
        trigger.hoverIcon = AssetFinder.GetHandInteractIcon();
        InitAudioClip();
    }

    void OnTriggerInteract(PlayerControllerB _player)
    {
        onButtonPressed?.Invoke();
        GetComponent<Animator>().SetTrigger("Push");
        InitAudioClip();
        GetComponent<AudioSource>().Play();
    }

    void InitAudioClip()
    {
        if(buttonSound != null) return;

        buttonSound = AssetFinder.GetButtonAudioClip();

        if(buttonSound != null)
        {
            GetComponent<AudioSource>().clip = buttonSound;
        }
    }
}


}