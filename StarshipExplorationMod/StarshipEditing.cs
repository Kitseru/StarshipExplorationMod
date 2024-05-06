using System;
using System.Collections.Generic;
using System.Linq;
using HarmonyLib;
using StarshipExplorationMod;
using Unity.Netcode;
using UnityEngine;

namespace StarshipExplorationMod{


internal class StarshipEditing
{
    public static void EditStarshipModel(GameObject _dropShipGO)
    {

        // Add InteriorProps Prefab
        GameObject interiorPropsObject = UnityEngine.Object.Instantiate(StarshipExploration.Ressources.LoadAsset<GameObject>("assets/prefabs/starshipinteriorprops.prefab"), Vector3.zero, Quaternion.identity, _dropShipGO.transform.Find("StarshipModel"));
        interiorPropsObject.name = "StarshipInteriorProps";
        interiorPropsObject.transform.localPosition = new Vector3(0, 0, 0);
        interiorPropsObject.transform.localRotation = Quaternion.Euler(0, 0, 0);
        interiorPropsObject.transform.localScale = new Vector3(1, 1, 1);

        // Replace meshes
        GameObject interiorProps = StarshipExploration.Ressources.LoadAsset<GameObject>("assets/models/starshipinteriorprops.blend");
        _dropShipGO.transform.Find("StarshipModel/ShipBody").GetComponent<MeshFilter>().mesh = interiorProps.transform.Find("ShipBody").GetComponent<MeshFilter>().mesh;
        _dropShipGO.transform.Find("StarshipModel/ItemDoor").GetComponent<MeshFilter>().mesh = interiorProps.transform.Find("ItemDoor").GetComponent<MeshFilter>().mesh;

        // Change lights positions
        _dropShipGO.transform.Find("StarshipModel/InteriorLight.000").transform.localPosition = new Vector3(0f, 0.97f, -2.487f);
        _dropShipGO.transform.Find("StarshipModel/InteriorLight.001").transform.localPosition = new Vector3(-0.54f, 0.97f, -2.444f);
        _dropShipGO.transform.Find("StarshipModel/InteriorLight.002").transform.localPosition = new Vector3(0.54f, 0.97f, -2.444f);

        // Disable non needed colliders
        Collider[] colliders = _dropShipGO.transform.Find("StarshipModel/ShipBody").GetComponents<Collider>();
        foreach (Collider col in colliders)
        {
            col.enabled = false;
        }

        // Initialize Elevator
        interiorPropsObject.AddComponent<StarshipElevatorAnimationEvents>();

        var elevator = interiorPropsObject.AddComponent<StarshipElevator>();
        elevator.dropShip = _dropShipGO.GetComponent<ItemDropship>();

        var fakeElevator = UnityEngine.Object.Instantiate(StarshipExploration.Ressources.LoadAsset<GameObject>("assets/prefabs/starshipelevatorroom.prefab"), new Vector3(-1278f, -200f, -14f), Quaternion.identity);
        elevator.fakeElevator = fakeElevator;

        // Initialize Elevator Buttons
        List<StarshipElevatorButton> elevatorButtons = [];

        elevatorButtons.Add(interiorPropsObject.transform.Find("ButtonDown").gameObject.AddComponent<StarshipElevatorButton>());
        elevatorButtons.Add(interiorPropsObject.transform.Find("ButtonUp").gameObject.AddComponent<StarshipElevatorButton>());
        elevatorButtons.Add(fakeElevator.transform.Find("ButtonExit").gameObject.AddComponent<StarshipElevatorButton>());

        elevator.buttons = elevatorButtons.ToArray();
        TriggersManager.AddToTriggerCollection(elevatorButtons.ToArray());

        foreach(var button in elevatorButtons)
        {
            Debug.Log("a button was found !" + button.gameObject.name);
        }

        // Rebind Animation Events
        interiorPropsObject.GetComponent<Animator>().Rebind();

        StarshipExploration.mls.LogInfo("Ship editing is complete");
    }
}


}
