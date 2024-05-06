using System;
using System.Collections;
using System.Collections.Generic;
using GameNetcodeStuff;
using HarmonyLib;
using StarshipExplorationMod;
using Unity.Netcode;
using UnityEngine;

namespace StarshipExplorationMod{


internal class PlayerStarshipExtras : NetworkBehaviour
{
    private PlayerControllerB? playerController;
    public bool wasInStarshipElevator = false;
    public bool inStarshipElevator = false;
    public bool inTeleportArea = false;
    public Transform? startshipElevatorTransform;
    public StarshipElevator? currentElevatorRoom;

    private void Start()
    {
        playerController = GetComponent<PlayerControllerB>();
        StarshipElevator.onElevatorClosed += TeleportToFakeElevator;
    }

    private void OnTriggerEnter(Collider other)
    {
        if(other.name == "StarshipElevatorTrigger")
        {
            inStarshipElevator = true;
            startshipElevatorTransform = other.transform.parent.Find("ElevatorTransform");
            Debug.Log(startshipElevatorTransform.name);
        }

        if(other.name == "StarshipElevatorTeleportArea")
        {
            Debug.Log("Inside teleport area !");
            inTeleportArea = true;
            currentElevatorRoom = other.transform.parent.GetComponentInChildren<StarshipElevator>();
        }
    }

    private void OnTriggerExit(Collider other)
    {
        if(other.name == "StarshipElevatorTrigger")
        {
            inStarshipElevator = false;
            startshipElevatorTransform = null;
        }
        
        if(other.name == "StarshipElevatorTeleportArea")
        {
            Debug.Log("Outside teleport area !");
            inTeleportArea = false;
            currentElevatorRoom = null;
        }
    }

    private void TeleportToFakeElevator(StarshipElevator _elevator)
    {
        Debug.Log("Try to teleport...");
        if(_elevator == currentElevatorRoom)
        {
            Debug.Log("Teleported !");
            transform.SetParent(playerController.playersManager.playersContainer);

            TransformInfos newTransform = CalculateRelativeTransform(startshipElevatorTransform, _elevator.fakeElevator.transform.Find("ElevatorTransform"), this.transform);

            Debug.Log("First object pos = " + startshipElevatorTransform.position);
            Debug.Log("Second object pos = " + _elevator.fakeElevator.transform.Find("ElevatorTransform").transform.position);
            Debug.Log("Myself pos = " + this.transform.position);
            Debug.Log("Calculated new pos = " + newTransform.pos);

            playerController?.TeleportPlayer(newTransform.pos);
            playerController.transform.rotation = newTransform.rot;

            Debug.Log("New Myself pos = " + this.transform.position);
        }
    }

    private TransformInfos CalculateRelativeTransform(Transform _parent1, Transform _parent2, Transform _child)
    {
        Vector3 relativePosition = _parent1.InverseTransformPoint(_child.position);
        Debug.Log("Relative pos with 1st object = " + relativePosition);
        Quaternion relativeRotation = Quaternion.Inverse(_parent1.rotation) * _child.rotation;

        Matrix4x4 relativeMatrix = Matrix4x4.TRS(relativePosition, Quaternion.identity, Vector3.one) *
                                Matrix4x4.TRS(Vector3.zero, relativeRotation, Vector3.one);

        Vector3 newPosition = _parent2.TransformPoint(relativeMatrix.GetColumn(3));
        Quaternion newRotation = _parent2.rotation * Quaternion.LookRotation(relativeMatrix.GetColumn(2), relativeMatrix.GetColumn(1));

        Debug.Log("Relative pos with 2st object = " + _parent2.InverseTransformPoint(newPosition));

        TransformInfos newTransform = new TransformInfos(newPosition, newRotation);
        

        return newTransform;
    }

    private struct TransformInfos()
    {
        public Vector3 pos;
        public Quaternion rot;

        public TransformInfos(Vector3 position, Quaternion rotation) : this()
        {
            pos = position;
            rot = rotation;
        }
    }
}


}