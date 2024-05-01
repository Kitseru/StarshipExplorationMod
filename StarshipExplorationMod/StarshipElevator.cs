using System;
using System.Collections.Generic;
using GameNetcodeStuff;
using HarmonyLib;
using StarshipExplorationMod;
using Unity.Netcode;
using UnityEngine;

internal class StarshipElevator : NetworkBehaviour
{
    public InteractTrigger? trigger;
    private Animator anim;
    private bool isDown = false;
    void Start()
    {
        if(trigger == null) return;

        trigger.onInteract.AddListener(CallElevatorDown);
        anim = GetComponent<Animator>();
    }

    public void CallElevatorDown(PlayerControllerB _player)
    {
        StarshipExploration.mls.LogInfo("Elevator called, animator set bool to " + !isDown);
        anim.SetBool("Down", !isDown);
    }
}
