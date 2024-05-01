using System;
using System.Collections.Generic;
using HarmonyLib;
using StarshipExplorationMod;
using Unity.Netcode;
using UnityEngine;

internal class StarshipEditing
{
    public static void EditStarshipModel(GameObject _dropShip)
    {

        // Add InteriorProps Prefab
        GameObject interiorPropsObject = UnityEngine.Object.Instantiate(StarshipExploration.Ressources.LoadAsset<GameObject>("assets/prefabs/starshipinteriorprops.prefab"), Vector3.zero, Quaternion.identity, _dropShip.transform.Find("StarshipModel"));
        interiorPropsObject.name = "StarshipInteriorProps";
        interiorPropsObject.transform.localPosition = new Vector3(0, 0, 0);
        interiorPropsObject.transform.localRotation = Quaternion.Euler(0, 0, 0);
        interiorPropsObject.transform.localScale = new Vector3(1, 1, 1);

        // Replace meshes
        GameObject interiorProps = StarshipExploration.Ressources.LoadAsset<GameObject>("assets/models/starshipinteriorprops.blend");
        _dropShip.transform.Find("StarshipModel/ShipBody").GetComponent<MeshFilter>().mesh = interiorProps.transform.Find("ShipBody").GetComponent<MeshFilter>().mesh;
        _dropShip.transform.Find("StarshipModel/ItemDoor").GetComponent<MeshFilter>().mesh = interiorProps.transform.Find("ItemDoor").GetComponent<MeshFilter>().mesh;

        // Change lights positions
        _dropShip.transform.Find("StarshipModel/InteriorLight.000").transform.localPosition = new Vector3(0f, 0.97f, -2.487f);
        _dropShip.transform.Find("StarshipModel/InteriorLight.001").transform.localPosition = new Vector3(-0.54f, 0.97f, -2.444f);
        _dropShip.transform.Find("StarshipModel/InteriorLight.002").transform.localPosition = new Vector3(0.54f, 0.97f, -2.444f);

        // Initialize Elevator Button
        interiorPropsObject.AddComponent<StarshipElevator>();
        interiorPropsObject.GetComponent<StarshipElevator>().trigger = _dropShip.transform.Find("StarshipModel/StarshipInteriorProps/ButtonTrigger").GetComponent<InteractTrigger>();

        StarshipExploration.mls.LogInfo("Ship editing is complete");
    }
}