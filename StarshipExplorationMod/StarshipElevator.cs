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
    private Animator? anim;
    private bool isDown = false;
    public bool isRetracted = true;
    void Start()
    {
        if(trigger == null) return;

        trigger.onInteract.AddListener(ElevatorSwitch);
        GetComponent<StarshipElevatorAnimationEvents>().onElevatorStops += SetElevatorFloor;
        anim = GetComponent<Animator>();
    }

    private void ElevatorSwitch(PlayerControllerB _player)
    {
        StarshipExploration.mls.LogInfo("Elevator called, animator set bool to " + !isDown);
        ElevatorSwitchServerRpc();
    }

    [ServerRpc]
    private void ElevatorSwitchServerRpc()
    {
        anim?.SetBool("Down", !isDown);
        isRetracted = false;
        ElevatorSwitchClientRpc(!isDown);
    }

    [ClientRpc]
    private void ElevatorSwitchClientRpc(bool _isDown)
    {
        Debug.Log("--------- Elevator Retracted = False !");
        isRetracted = false;
        anim?.SetBool("Down", _isDown);
    }

    private void SetElevatorFloor(bool _isDown)
    {
/*         if(!IsServer)
        {
            return;
        } */

        isDown = _isDown;
        Debug.Log("New Elevator position : isDown = " + isDown);

        if(!_isDown)
        {
            Debug.Log("--------- Elevator Retracted = True !");
            isRetracted = true;
        }
    }
}
