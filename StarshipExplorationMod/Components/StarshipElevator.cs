using System;
using System.Collections.Generic;
using GameNetcodeStuff;
using HarmonyLib;
using StarshipExplorationMod;
using Unity.Netcode;
using UnityEngine;

namespace StarshipExplorationMod{


internal class StarshipElevator : NetworkBehaviour
{
    public StarshipElevatorButton[]? buttons;
    public ItemDropship? dropShip;
    public GameObject? fakeElevator;
    private Animator? anim;
    private bool isDown = false;
    public bool isRetracted = true;
    public static Action<StarshipElevator>? onElevatorClosed;
    void Start()
    {
        if(buttons != null)
        {
            foreach (var button in buttons)
            {
                button.onButtonPressed += ElevatorSwitch;
            }
        }

        GetComponent<StarshipElevatorAnimationEvents>().onElevatorStops += SetElevatorFloor;
        anim = GetComponent<Animator>();
    }

    private void ElevatorSwitch()
    {
        StarshipExploration.mls.LogInfo("Elevator called, animator set bool to " + !isDown);
        ElevatorSwitchServerRpc();
    }

    [ServerRpc]
    private void ElevatorSwitchServerRpc()
    {
        if(dropShip == null) return;

        if(dropShip.shipLanded && dropShip.shipDoorsOpened)
        {
            anim?.SetBool("Down", !isDown);
            isRetracted = false;
            ElevatorSwitchClientRpc(!isDown);
        }
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
        isDown = _isDown;
        Debug.Log("New Elevator position : isDown = " + isDown);

        if(!_isDown)
        {
            Debug.Log("--------- Elevator Retracted = True !");
            onElevatorClosed?.Invoke(this);
            isRetracted = true;
        }
    }

    public void ShipLeave()
    {
        anim?.SetBool("Down", false);
        isRetracted = false;
    }
}


}