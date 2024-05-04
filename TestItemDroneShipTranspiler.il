.class public auto ansi beforefieldinit ItemDropship
	extends [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour
{
	// Fields
	.field public bool deliveringOrder
	.field public bool shipLanded
	.field public bool shipDoorsOpened
	.field public class [UnityEngine.AnimationModule]UnityEngine.Animator shipAnimator
	.field public float32 shipTimer
	.field public bool playersFirstOrder
	.field private class StartOfRound playersManager
	.field private class Terminal terminalScript
	.field private class [netstandard]System.Collections.Generic.List`1<int32> itemsToDeliver
	.field public class [UnityEngine.CoreModule]UnityEngine.Transform[] itemSpawnPositions
	.field private float32 noiseInterval
	.field private int32 timesPlayedWithoutTurningOff
	.field public class InteractTrigger triggerScript

	// Methods
	.method private hidebysig 
		instance void Start () cil managed 
	{
		// Method begins at RVA 0x4bcc4
		// Header size: 1
		// Code size: 23 (0x17)
		.maxstack 8

		// playersManager = Object.FindObjectOfType<StartOfRound>();
		IL_0000: ldarg.0
		IL_0001: call !!0 [UnityEngine.CoreModule]UnityEngine.Object::FindObjectOfType<class StartOfRound>()
		IL_0006: stfld class StartOfRound ItemDropship::playersManager
		// terminalScript = Object.FindObjectOfType<Terminal>();
		IL_000b: ldarg.0
		IL_000c: call !!0 [UnityEngine.CoreModule]UnityEngine.Object::FindObjectOfType<class Terminal>()
		IL_0011: stfld class Terminal ItemDropship::terminalScript
		// }
		IL_0016: ret
	} // end of method ItemDropship::Start

	.method private hidebysig 
		instance void Update () cil managed 
	{
		// Method begins at RVA 0x4bcdc
		// Header size: 12
		// Code size: 281 (0x119)
		.maxstack 7

		// if (!base.IsServer)
		IL_0000: ldarg.0
		IL_0001: call instance bool [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour::get_IsServer()
		IL_0006: brfalse IL_0118

		// if (!deliveringOrder)
		IL_000b: ldarg.0
		IL_000c: ldfld bool ItemDropship::deliveringOrder
		IL_0011: brtrue.s IL_0079

		// if (terminalScript.orderedItemsFromTerminal.Count > 0)
		IL_0013: ldarg.0
		IL_0014: ldfld class Terminal ItemDropship::terminalScript
		IL_0019: ldfld class [netstandard]System.Collections.Generic.List`1<int32> Terminal::orderedItemsFromTerminal
		IL_001e: callvirt instance int32 class [netstandard]System.Collections.Generic.List`1<int32>::get_Count()
		IL_0023: ldc.i4.0
		IL_0024: ble IL_0118

		// if (playersManager.shipHasLanded)
		IL_0029: ldarg.0
		IL_002a: ldfld class StartOfRound ItemDropship::playersManager
		IL_002f: ldfld bool StartOfRound::shipHasLanded
		IL_0034: brfalse.s IL_0048

		// shipTimer += Time.deltaTime;
		IL_0036: ldarg.0
		IL_0037: ldarg.0
		IL_0038: ldfld float32 ItemDropship::shipTimer
		IL_003d: call float32 [UnityEngine.CoreModule]UnityEngine.Time::get_deltaTime()
		IL_0042: add
		IL_0043: stfld float32 ItemDropship::shipTimer

		// if (playersFirstOrder)
		IL_0048: ldarg.0
		IL_0049: ldfld bool ItemDropship::playersFirstOrder
		IL_004e: brfalse.s IL_0062

		// playersFirstOrder = false;
		IL_0050: ldarg.0
		IL_0051: ldc.i4.0
		IL_0052: stfld bool ItemDropship::playersFirstOrder
		// shipTimer = 20f;
		IL_0057: ldarg.0
		IL_0058: ldc.r4 20
		IL_005d: stfld float32 ItemDropship::shipTimer

		// if (shipTimer > 40f)
		IL_0062: ldarg.0
		IL_0063: ldfld float32 ItemDropship::shipTimer
		IL_0068: ldc.r4 40
		IL_006d: ble.un IL_0118

		// LandShipOnServer();
		IL_0072: ldarg.0
		IL_0073: call instance void ItemDropship::LandShipOnServer()
		// }
		IL_0078: ret

		// else if (shipLanded)
		IL_0079: ldarg.0
		IL_007a: ldfld bool ItemDropship::shipLanded
		IL_007f: brfalse IL_0118

		//-------- CUSTOM
		// this.GetComponent<StarshipElevator>().isRetracted == false
		//IL_1001: ldarg.0
		//IL_1002: call instance class [UnityEngine.CoreModule]UnityEngine.Component UnityEngine.GameObject::GetComponent<class StarshipElevator>()
		//IL_1003: ldfld bool StarshipElevator::isRetracted
		//IL_1004: brfalse.s IL_0096

		// shipTimer += Time.deltaTime;
		IL_0084: ldarg.0
		IL_0085: ldarg.0
		IL_0086: ldfld float32 ItemDropship::shipTimer
		IL_008b: call float32 [UnityEngine.CoreModule]UnityEngine.Time::get_deltaTime()
		IL_0090: add
		IL_0091: stfld float32 ItemDropship::shipTimer
		// if (shipTimer > 30f)
		IL_0096: ldarg.0
		IL_0097: ldfld float32 ItemDropship::shipTimer
		IL_009c: ldc.r4 30
		IL_00a1: ble.un.s IL_00b7
		

        //-------- CUSTOM
		// this.GetComponent<StarshipElevator>().isRetracted == false
        IL_0001: ldarg.0
        IL_0002: call bool ItemDropShipPatch::isElevatorRetracted(class ItemDropship)
        IL_0007: stloc.0
        IL_0008: ldloc.0
        IL_0009: brfalse.s IL_00a3

        //-------- CUSTOM
		// shipTimer -= Time.deltaTime;
		IL_000c: ldarg.0
        IL_000d: ldarg.0
        IL_000e: ldfld float32 ItemDropship::shipTimer
        IL_0013: call float32 [UnityEngine.CoreModule]UnityEngine.Time::get_deltaTime()
        IL_0018: sub
        IL_0019: stfld float32 ItemDropship::shipTimer
		IL_003e: ldstr "----------- Substracting DeltaTime"
        IL_002e: call void [System.Console]System.Console::WriteLine(string)
		IL_0035: br.s IL_00b7

		// timesPlayedWithoutTurningOff = 0;
		IL_00a3: ldarg.0
		IL_00a4: ldc.i4.0
		IL_00a5: stfld int32 ItemDropship::timesPlayedWithoutTurningOff
		// shipLanded = false;
		IL_00aa: ldarg.0
		IL_00ab: ldc.i4.0
		IL_00ac: stfld bool ItemDropship::shipLanded
		// ShipLeaveClientRpc();
		IL_00b1: ldarg.0
		IL_00b2: call instance void ItemDropship::ShipLeaveClientRpc()

		// if (noiseInterval <= 0f)
		IL_00b7: ldarg.0
		IL_00b8: ldfld float32 ItemDropship::noiseInterval
		IL_00bd: ldc.r4 0.0
		IL_00c2: bgt.un.s IL_0106

		// noiseInterval = 1f;
		IL_00c4: ldarg.0
		IL_00c5: ldc.r4 1
		IL_00ca: stfld float32 ItemDropship::noiseInterval
		// timesPlayedWithoutTurningOff++;
		IL_00cf: ldarg.0
		IL_00d0: ldarg.0
		IL_00d1: ldfld int32 ItemDropship::timesPlayedWithoutTurningOff
		IL_00d6: ldc.i4.1
		IL_00d7: add
		IL_00d8: stfld int32 ItemDropship::timesPlayedWithoutTurningOff
		// RoundManager.Instance.PlayAudibleNoise(base.transform.position, 60f, 1.3f, timesPlayedWithoutTurningOff, noiseIsInsideClosedShip: false, 94);
		IL_00dd: call class RoundManager RoundManager::get_Instance()
		IL_00e2: ldarg.0
		IL_00e3: call instance class [UnityEngine.CoreModule]UnityEngine.Transform [UnityEngine.CoreModule]UnityEngine.Component::get_transform()
		IL_00e8: callvirt instance valuetype [UnityEngine.CoreModule]UnityEngine.Vector3 [UnityEngine.CoreModule]UnityEngine.Transform::get_position()
		IL_00ed: ldc.r4 60
		IL_00f2: ldc.r4 1.3
		IL_00f7: ldarg.0
		IL_00f8: ldfld int32 ItemDropship::timesPlayedWithoutTurningOff
		IL_00fd: ldc.i4.0
		IL_00fe: ldc.i4.s 94
		IL_0100: callvirt instance void RoundManager::PlayAudibleNoise(valuetype [UnityEngine.CoreModule]UnityEngine.Vector3, float32, float32, int32, bool, int32)
		// (no C# code)
		IL_0105: ret

		// noiseInterval -= Time.deltaTime;
		IL_0106: ldarg.0
		IL_0107: ldarg.0
		// (no C# code)
		IL_0108: ldfld float32 ItemDropship::noiseInterval
		IL_010d: call float32 [UnityEngine.CoreModule]UnityEngine.Time::get_deltaTime()
		IL_0112: sub
		IL_0113: stfld float32 ItemDropship::noiseInterval

		IL_0118: ret
	} // end of method ItemDropship::Update

	.method public hidebysig 
		instance void TryOpeningShip () cil managed 
	{
		// Method begins at RVA 0x4be01
		// Header size: 1
		// Code size: 31 (0x1f)
		.maxstack 8

		// if (!shipDoorsOpened)
		IL_0000: ldarg.0
		IL_0001: ldfld bool ItemDropship::shipDoorsOpened
		IL_0006: brfalse.s IL_0009

		// }
		IL_0008: ret

		// if (base.IsServer)
		IL_0009: ldarg.0
		IL_000a: call instance bool [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour::get_IsServer()
		IL_000f: brfalse.s IL_0018

		// OpenShipDoorsOnServer();
		IL_0011: ldarg.0
		IL_0012: call instance void ItemDropship::OpenShipDoorsOnServer()
		// OpenShipServerRpc();
		IL_0017: ret

		IL_0018: ldarg.0
		IL_0019: call instance void ItemDropship::OpenShipServerRpc()
		// (no C# code)
		IL_001e: ret
	} // end of method ItemDropship::TryOpeningShip

	.method public hidebysig 
		instance void OpenShipServerRpc () cil managed 
	{
		.custom instance void [Unity.Netcode.Runtime]Unity.Netcode.ServerRpcAttribute::.ctor() = (
			01 00 01 00 53 02 10 52 65 71 75 69 72 65 4f 77
			6e 65 72 73 68 69 70 00
		)
		// Method begins at RVA 0x4be24
		// Header size: 12
		// Code size: 194 (0xc2)
		.maxstack 5
		.locals init (
			[0] class [Unity.Netcode.Runtime]Unity.Netcode.NetworkManager,
			[1] valuetype [Unity.Netcode.Runtime]Unity.Netcode.FastBufferWriter,
			[2] valuetype [Unity.Netcode.Runtime]Unity.Netcode.ServerRpcParams
		)

		// NetworkManager networkManager = base.NetworkManager;
		IL_0000: ldarg.0
		IL_0001: call instance class [Unity.Netcode.Runtime]Unity.Netcode.NetworkManager [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour::get_NetworkManager()
		IL_0006: stloc 0
		// if ((object)networkManager != null && networkManager.IsListening)
		IL_000a: ldloc 0
		IL_000e: brfalse IL_0021

		IL_0013: ldloc 0
		IL_0017: callvirt instance bool [Unity.Netcode.Runtime]Unity.Netcode.NetworkManager::get_IsListening()
		IL_001c: brtrue IL_0022

		// }
		IL_0021: ret

		// if (__rpc_exec_stage != __RpcExecStage.Server && (networkManager.IsClient || networkManager.IsHost))
		IL_0022: nop
		IL_0023: ldarg.0
		IL_0024: ldfld valuetype [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour/__RpcExecStage [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour::__rpc_exec_stage
		IL_0029: ldc.i4 1
		IL_002e: ceq
		IL_0030: ldc.i4 0
		IL_0035: ceq
		IL_0037: brfalse IL_008a

		// (no C# code)
		IL_003c: ldloc 0
		IL_0040: callvirt instance bool [Unity.Netcode.Runtime]Unity.Netcode.NetworkManager::get_IsClient()
		IL_0045: brtrue IL_0058

		IL_004a: ldloc 0
		IL_004e: callvirt instance bool [Unity.Netcode.Runtime]Unity.Netcode.NetworkManager::get_IsHost()
		IL_0053: brfalse IL_008a

		// FastBufferWriter bufferWriter = __beginSendServerRpc(638792059u, serverRpcParams, RpcDelivery.Reliable);
		IL_0058: nop
		IL_0059: ldarg.0
		IL_005a: ldc.i4 638792059
		IL_005f: ldloc 2
		IL_0063: ldc.i4 0
		IL_0068: call instance valuetype [Unity.Netcode.Runtime]Unity.Netcode.FastBufferWriter [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour::__beginSendServerRpc(uint32, valuetype [Unity.Netcode.Runtime]Unity.Netcode.ServerRpcParams, valuetype [Unity.Netcode.Runtime]Unity.Netcode.RpcDelivery)
		IL_006d: stloc 1
		// __endSendServerRpc(ref bufferWriter, 638792059u, serverRpcParams, RpcDelivery.Reliable);
		IL_0071: nop
		IL_0072: ldarg.0
		IL_0073: ldloca 1
		IL_0077: ldc.i4 638792059
		IL_007c: ldloc 2
		IL_0080: ldc.i4 0
		IL_0085: call instance void [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour::__endSendServerRpc(valuetype [Unity.Netcode.Runtime]Unity.Netcode.FastBufferWriter&, uint32, valuetype [Unity.Netcode.Runtime]Unity.Netcode.ServerRpcParams, valuetype [Unity.Netcode.Runtime]Unity.Netcode.RpcDelivery)

		// if (__rpc_exec_stage == __RpcExecStage.Server && (networkManager.IsServer || networkManager.IsHost))
		IL_008a: nop
		IL_008b: ldarg.0
		IL_008c: ldfld valuetype [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour/__RpcExecStage [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour::__rpc_exec_stage
		IL_0091: ldc.i4 1
		IL_0096: ceq
		IL_0098: brfalse IL_00b9

		IL_009d: ldloc 0
		IL_00a1: callvirt instance bool [Unity.Netcode.Runtime]Unity.Netcode.NetworkManager::get_IsServer()
		IL_00a6: brtrue IL_00ba

		// (no C# code)
		IL_00ab: ldloc 0
		IL_00af: callvirt instance bool [Unity.Netcode.Runtime]Unity.Netcode.NetworkManager::get_IsHost()
		IL_00b4: brtrue IL_00ba

		IL_00b9: ret

		// OpenShipDoorsOnServer();
		IL_00ba: nop
		IL_00bb: ldarg.0
		IL_00bc: call instance void ItemDropship::OpenShipDoorsOnServer()
		// (no C# code)
		IL_00c1: ret
	} // end of method ItemDropship::OpenShipServerRpc

	.method private hidebysig 
		instance void OpenShipDoorsOnServer () cil managed 
	{
		// Method begins at RVA 0x4bef4
		// Header size: 12
		// Code size: 161 (0xa1)
		.maxstack 4
		.locals init (
			[0] int32,
			[1] int32
		)

		// if (shipLanded && !shipDoorsOpened)
		IL_0000: ldarg.0
		IL_0001: ldfld bool ItemDropship::shipLanded
		IL_0006: brfalse.s IL_0010

		IL_0008: ldarg.0
		IL_0009: ldfld bool ItemDropship::shipDoorsOpened
		IL_000e: brfalse.s IL_0011

		// }
		IL_0010: ret

		// int num = 0;
		IL_0011: ldc.i4.0
		IL_0012: stloc.0
		// for (int i = 0; i < itemsToDeliver.Count; i++)
		IL_0013: ldc.i4.0
		IL_0014: stloc.1
		// GameObject obj = Object.Instantiate(terminalScript.buyableItemsList[itemsToDeliver[i]].spawnPrefab, itemSpawnPositions[num].position, Quaternion.identity, playersManager.propsContainer);
		IL_0015: br.s IL_0081
		// loop start (head: IL_0081)
			IL_0017: ldarg.0
			IL_0018: ldfld class Terminal ItemDropship::terminalScript
			IL_001d: ldfld class Item[] Terminal::buyableItemsList
			IL_0022: ldarg.0
			IL_0023: ldfld class [netstandard]System.Collections.Generic.List`1<int32> ItemDropship::itemsToDeliver
			IL_0028: ldloc.1
			IL_0029: callvirt instance !0 class [netstandard]System.Collections.Generic.List`1<int32>::get_Item(int32)
			IL_002e: ldelem.ref
			IL_002f: ldfld class [UnityEngine.CoreModule]UnityEngine.GameObject Item::spawnPrefab
			IL_0034: ldarg.0
			IL_0035: ldfld class [UnityEngine.CoreModule]UnityEngine.Transform[] ItemDropship::itemSpawnPositions
			IL_003a: ldloc.0
			IL_003b: ldelem.ref
			IL_003c: callvirt instance valuetype [UnityEngine.CoreModule]UnityEngine.Vector3 [UnityEngine.CoreModule]UnityEngine.Transform::get_position()
			IL_0041: call valuetype [UnityEngine.CoreModule]UnityEngine.Quaternion [UnityEngine.CoreModule]UnityEngine.Quaternion::get_identity()
			IL_0046: ldarg.0
			IL_0047: ldfld class StartOfRound ItemDropship::playersManager
			IL_004c: ldfld class [UnityEngine.CoreModule]UnityEngine.Transform StartOfRound::propsContainer
			IL_0051: call !!0 [UnityEngine.CoreModule]UnityEngine.Object::Instantiate<class [UnityEngine.CoreModule]UnityEngine.GameObject>(!!0, valuetype [UnityEngine.CoreModule]UnityEngine.Vector3, valuetype [UnityEngine.CoreModule]UnityEngine.Quaternion, class [UnityEngine.CoreModule]UnityEngine.Transform)
			// obj.GetComponent<GrabbableObject>().fallTime = 0f;
			IL_0056: dup
			IL_0057: callvirt instance !!0 [UnityEngine.CoreModule]UnityEngine.GameObject::GetComponent<class GrabbableObject>()
			IL_005c: ldc.r4 0.0
			IL_0061: stfld float32 GrabbableObject::fallTime
			// obj.GetComponent<NetworkObject>().Spawn();
			IL_0066: callvirt instance !!0 [UnityEngine.CoreModule]UnityEngine.GameObject::GetComponent<class [Unity.Netcode.Runtime]Unity.Netcode.NetworkObject>()
			IL_006b: ldc.i4.0
			IL_006c: callvirt instance void [Unity.Netcode.Runtime]Unity.Netcode.NetworkObject::Spawn(bool)
			// num = ((num < 3) ? (num + 1) : 0);
			IL_0071: ldloc.0
			IL_0072: ldc.i4.3
			IL_0073: blt.s IL_0079

			IL_0075: ldc.i4.0
			IL_0076: stloc.0
			// (no C# code)
			IL_0077: br.s IL_007d

			// for (int i = 0; i < itemsToDeliver.Count; i++)
			IL_0079: ldloc.0
			IL_007a: ldc.i4.1
			IL_007b: add
			IL_007c: stloc.0

			IL_007d: ldloc.1
			IL_007e: ldc.i4.1
			IL_007f: add
			IL_0080: stloc.1

			// for (int i = 0; i < itemsToDeliver.Count; i++)
			IL_0081: ldloc.1
			IL_0082: ldarg.0
			IL_0083: ldfld class [netstandard]System.Collections.Generic.List`1<int32> ItemDropship::itemsToDeliver
			IL_0088: callvirt instance int32 class [netstandard]System.Collections.Generic.List`1<int32>::get_Count()
			IL_008d: blt.s IL_0017
		// end loop

		// itemsToDeliver.Clear();
		IL_008f: ldarg.0
		IL_0090: ldfld class [netstandard]System.Collections.Generic.List`1<int32> ItemDropship::itemsToDeliver
		IL_0095: callvirt instance void class [netstandard]System.Collections.Generic.List`1<int32>::Clear()
		// OpenShipClientRpc();
		IL_009a: ldarg.0
		IL_009b: call instance void ItemDropship::OpenShipClientRpc()
		// (no C# code)
		IL_00a0: ret
	} // end of method ItemDropship::OpenShipDoorsOnServer

	.method public hidebysig 
		instance void OpenShipClientRpc () cil managed 
	{
		.custom instance void [Unity.Netcode.Runtime]Unity.Netcode.ClientRpcAttribute::.ctor() = (
			01 00 00 00
		)
		// Method begins at RVA 0x4bfa4
		// Header size: 12
		// Code size: 224 (0xe0)
		.maxstack 5
		.locals init (
			[0] class [Unity.Netcode.Runtime]Unity.Netcode.NetworkManager,
			[1] valuetype [Unity.Netcode.Runtime]Unity.Netcode.FastBufferWriter,
			[2] valuetype [Unity.Netcode.Runtime]Unity.Netcode.ClientRpcParams
		)

		// NetworkManager networkManager = base.NetworkManager;
		IL_0000: ldarg.0
		IL_0001: call instance class [Unity.Netcode.Runtime]Unity.Netcode.NetworkManager [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour::get_NetworkManager()
		IL_0006: stloc 0
		// if ((object)networkManager != null && networkManager.IsListening)
		IL_000a: ldloc 0
		IL_000e: brfalse IL_0021

		IL_0013: ldloc 0
		IL_0017: callvirt instance bool [Unity.Netcode.Runtime]Unity.Netcode.NetworkManager::get_IsListening()
		IL_001c: brtrue IL_0022

		// }
		IL_0021: ret

		// if (__rpc_exec_stage != __RpcExecStage.Client && (networkManager.IsServer || networkManager.IsHost))
		IL_0022: nop
		IL_0023: ldarg.0
		IL_0024: ldfld valuetype [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour/__RpcExecStage [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour::__rpc_exec_stage
		IL_0029: ldc.i4 2
		IL_002e: ceq
		IL_0030: ldc.i4 0
		IL_0035: ceq
		IL_0037: brfalse IL_008a

		// (no C# code)
		IL_003c: ldloc 0
		IL_0040: callvirt instance bool [Unity.Netcode.Runtime]Unity.Netcode.NetworkManager::get_IsServer()
		IL_0045: brtrue IL_0058

		IL_004a: ldloc 0
		IL_004e: callvirt instance bool [Unity.Netcode.Runtime]Unity.Netcode.NetworkManager::get_IsHost()
		IL_0053: brfalse IL_008a

		// FastBufferWriter bufferWriter = __beginSendClientRpc(3113622207u, clientRpcParams, RpcDelivery.Reliable);
		IL_0058: nop
		IL_0059: ldarg.0
		IL_005a: ldc.i4 -1181345089
		IL_005f: ldloc 2
		IL_0063: ldc.i4 0
		IL_0068: call instance valuetype [Unity.Netcode.Runtime]Unity.Netcode.FastBufferWriter [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour::__beginSendClientRpc(uint32, valuetype [Unity.Netcode.Runtime]Unity.Netcode.ClientRpcParams, valuetype [Unity.Netcode.Runtime]Unity.Netcode.RpcDelivery)
		IL_006d: stloc 1
		// __endSendClientRpc(ref bufferWriter, 3113622207u, clientRpcParams, RpcDelivery.Reliable);
		IL_0071: nop
		IL_0072: ldarg.0
		IL_0073: ldloca 1
		IL_0077: ldc.i4 -1181345089
		IL_007c: ldloc 2
		IL_0080: ldc.i4 0
		IL_0085: call instance void [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour::__endSendClientRpc(valuetype [Unity.Netcode.Runtime]Unity.Netcode.FastBufferWriter&, uint32, valuetype [Unity.Netcode.Runtime]Unity.Netcode.ClientRpcParams, valuetype [Unity.Netcode.Runtime]Unity.Netcode.RpcDelivery)

		// if (__rpc_exec_stage == __RpcExecStage.Client && (networkManager.IsClient || networkManager.IsHost))
		IL_008a: nop
		IL_008b: ldarg.0
		IL_008c: ldfld valuetype [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour/__RpcExecStage [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour::__rpc_exec_stage
		IL_0091: ldc.i4 2
		IL_0096: ceq
		IL_0098: brfalse IL_00b9

		IL_009d: ldloc 0
		IL_00a1: callvirt instance bool [Unity.Netcode.Runtime]Unity.Netcode.NetworkManager::get_IsClient()
		IL_00a6: brtrue IL_00ba

		// (no C# code)
		IL_00ab: ldloc 0
		IL_00af: callvirt instance bool [Unity.Netcode.Runtime]Unity.Netcode.NetworkManager::get_IsHost()
		IL_00b4: brtrue IL_00ba

		IL_00b9: ret

		// shipAnimator.SetBool("doorsOpened", value: true);
		IL_00ba: nop
		IL_00bb: ldarg.0
		IL_00bc: ldfld class [UnityEngine.AnimationModule]UnityEngine.Animator ItemDropship::shipAnimator
		IL_00c1: ldstr "doorsOpened"
		IL_00c6: ldc.i4.1
		IL_00c7: callvirt instance void [UnityEngine.AnimationModule]UnityEngine.Animator::SetBool(string, bool)
		// shipDoorsOpened = true;
		IL_00cc: ldarg.0
		IL_00cd: ldc.i4.1
		IL_00ce: stfld bool ItemDropship::shipDoorsOpened
		// triggerScript.interactable = false;
		IL_00d3: ldarg.0
		IL_00d4: ldfld class InteractTrigger ItemDropship::triggerScript
		IL_00d9: ldc.i4.0
		IL_00da: stfld bool InteractTrigger::interactable
		// (no C# code)
		IL_00df: ret
	} // end of method ItemDropship::OpenShipClientRpc

	.method public hidebysig 
		instance void ShipLandedAnimationEvent () cil managed 
	{
		// Method begins at RVA 0x4c090
		// Header size: 1
		// Code size: 8 (0x8)
		.maxstack 8

		// shipLanded = true;
		IL_0000: ldarg.0
		IL_0001: ldc.i4.1
		IL_0002: stfld bool ItemDropship::shipLanded
		// }
		IL_0007: ret
	} // end of method ItemDropship::ShipLandedAnimationEvent

	.method private hidebysig 
		instance void LandShipOnServer () cil managed 
	{
		// Method begins at RVA 0x4c09c
		// Header size: 12
		// Code size: 81 (0x51)
		.maxstack 2

		// shipTimer = 0f;
		IL_0000: ldarg.0
		IL_0001: ldc.r4 0.0
		IL_0006: stfld float32 ItemDropship::shipTimer
		// itemsToDeliver.Clear();
		IL_000b: ldarg.0
		IL_000c: ldfld class [netstandard]System.Collections.Generic.List`1<int32> ItemDropship::itemsToDeliver
		IL_0011: callvirt instance void class [netstandard]System.Collections.Generic.List`1<int32>::Clear()
		// itemsToDeliver.AddRange(terminalScript.orderedItemsFromTerminal);
		IL_0016: ldarg.0
		IL_0017: ldfld class [netstandard]System.Collections.Generic.List`1<int32> ItemDropship::itemsToDeliver
		IL_001c: ldarg.0
		IL_001d: ldfld class Terminal ItemDropship::terminalScript
		IL_0022: ldfld class [netstandard]System.Collections.Generic.List`1<int32> Terminal::orderedItemsFromTerminal
		IL_0027: callvirt instance void class [netstandard]System.Collections.Generic.List`1<int32>::AddRange(class [netstandard]System.Collections.Generic.IEnumerable`1<!0>)
		// terminalScript.orderedItemsFromTerminal.Clear();
		IL_002c: ldarg.0
		IL_002d: ldfld class Terminal ItemDropship::terminalScript
		IL_0032: ldfld class [netstandard]System.Collections.Generic.List`1<int32> Terminal::orderedItemsFromTerminal
		IL_0037: callvirt instance void class [netstandard]System.Collections.Generic.List`1<int32>::Clear()
		// playersFirstOrder = false;
		IL_003c: ldarg.0
		IL_003d: ldc.i4.0
		IL_003e: stfld bool ItemDropship::playersFirstOrder
		// deliveringOrder = true;
		IL_0043: ldarg.0
		IL_0044: ldc.i4.1
		IL_0045: stfld bool ItemDropship::deliveringOrder
		// LandShipClientRpc();
		IL_004a: ldarg.0
		IL_004b: call instance void ItemDropship::LandShipClientRpc()
		// }
		IL_0050: ret
	} // end of method ItemDropship::LandShipOnServer

	.method public hidebysig 
		instance void LandShipClientRpc () cil managed 
	{
		.custom instance void [Unity.Netcode.Runtime]Unity.Netcode.ClientRpcAttribute::.ctor() = (
			01 00 00 00
		)
		// Method begins at RVA 0x4c0fc
		// Header size: 12
		// Code size: 228 (0xe4)
		.maxstack 5
		.locals init (
			[0] class [Unity.Netcode.Runtime]Unity.Netcode.NetworkManager,
			[1] valuetype [Unity.Netcode.Runtime]Unity.Netcode.FastBufferWriter,
			[2] valuetype [Unity.Netcode.Runtime]Unity.Netcode.ClientRpcParams
		)

		// NetworkManager networkManager = base.NetworkManager;
		IL_0000: ldarg.0
		IL_0001: call instance class [Unity.Netcode.Runtime]Unity.Netcode.NetworkManager [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour::get_NetworkManager()
		IL_0006: stloc 0
		// if ((object)networkManager != null && networkManager.IsListening)
		IL_000a: ldloc 0
		IL_000e: brfalse IL_0021

		IL_0013: ldloc 0
		IL_0017: callvirt instance bool [Unity.Netcode.Runtime]Unity.Netcode.NetworkManager::get_IsListening()
		IL_001c: brtrue IL_0022

		// }
		IL_0021: ret

		// if (__rpc_exec_stage != __RpcExecStage.Client && (networkManager.IsServer || networkManager.IsHost))
		IL_0022: nop
		IL_0023: ldarg.0
		IL_0024: ldfld valuetype [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour/__RpcExecStage [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour::__rpc_exec_stage
		IL_0029: ldc.i4 2
		IL_002e: ceq
		IL_0030: ldc.i4 0
		IL_0035: ceq
		IL_0037: brfalse IL_008a

		// (no C# code)
		IL_003c: ldloc 0
		IL_0040: callvirt instance bool [Unity.Netcode.Runtime]Unity.Netcode.NetworkManager::get_IsServer()
		IL_0045: brtrue IL_0058

		IL_004a: ldloc 0
		IL_004e: callvirt instance bool [Unity.Netcode.Runtime]Unity.Netcode.NetworkManager::get_IsHost()
		IL_0053: brfalse IL_008a

		// FastBufferWriter bufferWriter = __beginSendClientRpc(1496861823u, clientRpcParams, RpcDelivery.Reliable);
		IL_0058: nop
		IL_0059: ldarg.0
		IL_005a: ldc.i4 1496861823
		IL_005f: ldloc 2
		IL_0063: ldc.i4 0
		IL_0068: call instance valuetype [Unity.Netcode.Runtime]Unity.Netcode.FastBufferWriter [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour::__beginSendClientRpc(uint32, valuetype [Unity.Netcode.Runtime]Unity.Netcode.ClientRpcParams, valuetype [Unity.Netcode.Runtime]Unity.Netcode.RpcDelivery)
		IL_006d: stloc 1
		// __endSendClientRpc(ref bufferWriter, 1496861823u, clientRpcParams, RpcDelivery.Reliable);
		IL_0071: nop
		IL_0072: ldarg.0
		IL_0073: ldloca 1
		IL_0077: ldc.i4 1496861823
		IL_007c: ldloc 2
		IL_0080: ldc.i4 0
		IL_0085: call instance void [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour::__endSendClientRpc(valuetype [Unity.Netcode.Runtime]Unity.Netcode.FastBufferWriter&, uint32, valuetype [Unity.Netcode.Runtime]Unity.Netcode.ClientRpcParams, valuetype [Unity.Netcode.Runtime]Unity.Netcode.RpcDelivery)

		// if (__rpc_exec_stage == __RpcExecStage.Client && (networkManager.IsClient || networkManager.IsHost))
		IL_008a: nop
		IL_008b: ldarg.0
		IL_008c: ldfld valuetype [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour/__RpcExecStage [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour::__rpc_exec_stage
		IL_0091: ldc.i4 2
		IL_0096: ceq
		IL_0098: brfalse IL_00b9

		IL_009d: ldloc 0
		IL_00a1: callvirt instance bool [Unity.Netcode.Runtime]Unity.Netcode.NetworkManager::get_IsClient()
		IL_00a6: brtrue IL_00ba

		// (no C# code)
		IL_00ab: ldloc 0
		IL_00af: callvirt instance bool [Unity.Netcode.Runtime]Unity.Netcode.NetworkManager::get_IsHost()
		IL_00b4: brtrue IL_00ba

		IL_00b9: ret

		// Object.FindObjectOfType<Terminal>().numberOfItemsInDropship = 0;
		IL_00ba: nop
		IL_00bb: call !!0 [UnityEngine.CoreModule]UnityEngine.Object::FindObjectOfType<class Terminal>()
		IL_00c0: ldc.i4.0
		IL_00c1: stfld int32 Terminal::numberOfItemsInDropship
		// shipAnimator.SetBool("landing", value: true);
		IL_00c6: ldarg.0
		IL_00c7: ldfld class [UnityEngine.AnimationModule]UnityEngine.Animator ItemDropship::shipAnimator
		IL_00cc: ldstr "landing"
		IL_00d1: ldc.i4.1
		IL_00d2: callvirt instance void [UnityEngine.AnimationModule]UnityEngine.Animator::SetBool(string, bool)
		// triggerScript.interactable = true;
		IL_00d7: ldarg.0
		IL_00d8: ldfld class InteractTrigger ItemDropship::triggerScript
		IL_00dd: ldc.i4.1
		IL_00de: stfld bool InteractTrigger::interactable
		// (no C# code)
		IL_00e3: ret
	} // end of method ItemDropship::LandShipClientRpc

	.method public hidebysig 
		instance void ShipLeaveClientRpc () cil managed 
	{
		.custom instance void [Unity.Netcode.Runtime]Unity.Netcode.ClientRpcAttribute::.ctor() = (
			01 00 00 00
		)
		// Method begins at RVA 0x4c1ec
		// Header size: 12
		// Code size: 194 (0xc2)
		.maxstack 5
		.locals init (
			[0] class [Unity.Netcode.Runtime]Unity.Netcode.NetworkManager,
			[1] valuetype [Unity.Netcode.Runtime]Unity.Netcode.FastBufferWriter,
			[2] valuetype [Unity.Netcode.Runtime]Unity.Netcode.ClientRpcParams
		)

		// NetworkManager networkManager = base.NetworkManager;
		IL_0000: ldarg.0
		IL_0001: call instance class [Unity.Netcode.Runtime]Unity.Netcode.NetworkManager [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour::get_NetworkManager()
		IL_0006: stloc 0
		// if ((object)networkManager != null && networkManager.IsListening)
		IL_000a: ldloc 0
		IL_000e: brfalse IL_0021

		IL_0013: ldloc 0
		IL_0017: callvirt instance bool [Unity.Netcode.Runtime]Unity.Netcode.NetworkManager::get_IsListening()
		IL_001c: brtrue IL_0022

		// }
		IL_0021: ret

		// if (__rpc_exec_stage != __RpcExecStage.Client && (networkManager.IsServer || networkManager.IsHost))
		IL_0022: nop
		IL_0023: ldarg.0
		IL_0024: ldfld valuetype [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour/__RpcExecStage [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour::__rpc_exec_stage
		IL_0029: ldc.i4 2
		IL_002e: ceq
		IL_0030: ldc.i4 0
		IL_0035: ceq
		IL_0037: brfalse IL_008a

		// (no C# code)
		IL_003c: ldloc 0
		IL_0040: callvirt instance bool [Unity.Netcode.Runtime]Unity.Netcode.NetworkManager::get_IsServer()
		IL_0045: brtrue IL_0058

		IL_004a: ldloc 0
		IL_004e: callvirt instance bool [Unity.Netcode.Runtime]Unity.Netcode.NetworkManager::get_IsHost()
		IL_0053: brfalse IL_008a

		// FastBufferWriter bufferWriter = __beginSendClientRpc(343429303u, clientRpcParams, RpcDelivery.Reliable);
		IL_0058: nop
		IL_0059: ldarg.0
		IL_005a: ldc.i4 343429303
		IL_005f: ldloc 2
		IL_0063: ldc.i4 0
		IL_0068: call instance valuetype [Unity.Netcode.Runtime]Unity.Netcode.FastBufferWriter [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour::__beginSendClientRpc(uint32, valuetype [Unity.Netcode.Runtime]Unity.Netcode.ClientRpcParams, valuetype [Unity.Netcode.Runtime]Unity.Netcode.RpcDelivery)
		IL_006d: stloc 1
		// __endSendClientRpc(ref bufferWriter, 343429303u, clientRpcParams, RpcDelivery.Reliable);
		IL_0071: nop
		IL_0072: ldarg.0
		IL_0073: ldloca 1
		IL_0077: ldc.i4 343429303
		IL_007c: ldloc 2
		IL_0080: ldc.i4 0
		IL_0085: call instance void [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour::__endSendClientRpc(valuetype [Unity.Netcode.Runtime]Unity.Netcode.FastBufferWriter&, uint32, valuetype [Unity.Netcode.Runtime]Unity.Netcode.ClientRpcParams, valuetype [Unity.Netcode.Runtime]Unity.Netcode.RpcDelivery)

		// if (__rpc_exec_stage == __RpcExecStage.Client && (networkManager.IsClient || networkManager.IsHost))
		IL_008a: nop
		IL_008b: ldarg.0
		IL_008c: ldfld valuetype [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour/__RpcExecStage [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour::__rpc_exec_stage
		IL_0091: ldc.i4 2
		IL_0096: ceq
		IL_0098: brfalse IL_00b9

		IL_009d: ldloc 0
		IL_00a1: callvirt instance bool [Unity.Netcode.Runtime]Unity.Netcode.NetworkManager::get_IsClient()
		IL_00a6: brtrue IL_00ba

		// (no C# code)
		IL_00ab: ldloc 0
		IL_00af: callvirt instance bool [Unity.Netcode.Runtime]Unity.Netcode.NetworkManager::get_IsHost()
		IL_00b4: brtrue IL_00ba

		IL_00b9: ret

		// ShipLeave();
		IL_00ba: nop
		IL_00bb: ldarg.0
		IL_00bc: call instance void ItemDropship::ShipLeave()
		// (no C# code)
		IL_00c1: ret
	} // end of method ItemDropship::ShipLeaveClientRpc

	.method public hidebysig 
		instance void ShipLeave () cil managed 
	{
		// Method begins at RVA 0x4c2bc
		// Header size: 12
		// Code size: 119 (0x77)
		.maxstack 6

		// shipDoorsOpened = false;
		IL_0000: ldarg.0
		IL_0001: ldc.i4.0
		IL_0002: stfld bool ItemDropship::shipDoorsOpened
		// shipAnimator.SetBool("doorsOpened", value: false);
		IL_0007: ldarg.0
		IL_0008: ldfld class [UnityEngine.AnimationModule]UnityEngine.Animator ItemDropship::shipAnimator
		IL_000d: ldstr "doorsOpened"
		IL_0012: ldc.i4.0
		IL_0013: callvirt instance void [UnityEngine.AnimationModule]UnityEngine.Animator::SetBool(string, bool)
		// shipLanded = false;
		IL_0018: ldarg.0
		IL_0019: ldc.i4.0
		IL_001a: stfld bool ItemDropship::shipLanded
		// shipAnimator.SetBool("landing", value: false);
		IL_001f: ldarg.0
		IL_0020: ldfld class [UnityEngine.AnimationModule]UnityEngine.Animator ItemDropship::shipAnimator
		IL_0025: ldstr "landing"
		IL_002a: ldc.i4.0
		IL_002b: callvirt instance void [UnityEngine.AnimationModule]UnityEngine.Animator::SetBool(string, bool)
		// deliveringOrder = false;
		IL_0030: ldarg.0
		IL_0031: ldc.i4.0
		IL_0032: stfld bool ItemDropship::deliveringOrder
		// if (itemsToDeliver.Count > 0)
		IL_0037: ldarg.0
		IL_0038: ldfld class [netstandard]System.Collections.Generic.List`1<int32> ItemDropship::itemsToDeliver
		IL_003d: callvirt instance int32 class [netstandard]System.Collections.Generic.List`1<int32>::get_Count()
		IL_0042: ldc.i4.0
		IL_0043: ble.s IL_0060

		// HUDManager.Instance.DisplayTip("Items missed!", "The vehicle returned with your purchased items. Our delivery fee cannot be refunded.");
		IL_0045: call class HUDManager HUDManager::get_Instance()
		IL_004a: ldstr "Items missed!"
		IL_004f: ldstr "The vehicle returned with your purchased items. Our delivery fee cannot be refunded."
		IL_0054: ldc.i4.0
		IL_0055: ldc.i4.0
		IL_0056: ldstr "LC_Tip1"
		IL_005b: callvirt instance void HUDManager::DisplayTip(string, string, bool, bool, string)

		// Object.FindObjectOfType<Terminal>().numberOfItemsInDropship = 0;
		IL_0060: call !!0 [UnityEngine.CoreModule]UnityEngine.Object::FindObjectOfType<class Terminal>()
		IL_0065: ldc.i4.0
		IL_0066: stfld int32 Terminal::numberOfItemsInDropship
		// itemsToDeliver.Clear();
		IL_006b: ldarg.0
		IL_006c: ldfld class [netstandard]System.Collections.Generic.List`1<int32> ItemDropship::itemsToDeliver
		IL_0071: callvirt instance void class [netstandard]System.Collections.Generic.List`1<int32>::Clear()
		// }
		IL_0076: ret
	} // end of method ItemDropship::ShipLeave

	.method public hidebysig 
		instance void ShipLandedInAnimation () cil managed 
	{
		// Method begins at RVA 0x4c090
		// Header size: 1
		// Code size: 8 (0x8)
		.maxstack 8

		// shipLanded = true;
		IL_0000: ldarg.0
		IL_0001: ldc.i4.1
		IL_0002: stfld bool ItemDropship::shipLanded
		// }
		IL_0007: ret
	} // end of method ItemDropship::ShipLandedInAnimation

	.method public hidebysig specialname rtspecialname 
		instance void .ctor () cil managed 
	{
		// Method begins at RVA 0x4c33f
		// Header size: 1
		// Code size: 25 (0x19)
		.maxstack 8

		// playersFirstOrder = true;
		IL_0000: ldarg.0
		IL_0001: ldc.i4.1
		IL_0002: stfld bool ItemDropship::playersFirstOrder
		// itemsToDeliver = new List<int>();
		IL_0007: ldarg.0
		IL_0008: newobj instance void class [netstandard]System.Collections.Generic.List`1<int32>::.ctor()
		IL_000d: stfld class [netstandard]System.Collections.Generic.List`1<int32> ItemDropship::itemsToDeliver
		// base..ctor();
		IL_0012: ldarg.0
		IL_0013: call instance void [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour::.ctor()
		// }
		IL_0018: ret
	} // end of method ItemDropship::.ctor

	.method family hidebysig virtual 
		instance void __initializeVariables () cil managed 
	{
		// Method begins at RVA 0x4c35c
		// Header size: 12
		// Code size: 10 (0xa)
		.maxstack 1
		.locals (
			[0] bool
		)

		// {
		IL_0000: nop
		// base.__initializeVariables();
		IL_0001: nop
		IL_0002: ldarg.0
		IL_0003: call instance void [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour::__initializeVariables()
		// }
		IL_0008: nop
		IL_0009: ret
	} // end of method ItemDropship::__initializeVariables

	.method assembly static 
		void InitializeRPCS_ItemDropship () cil managed 
	{
		.custom instance void [UnityEngine.CoreModule]UnityEngine.RuntimeInitializeOnLoadMethodAttribute::.ctor() = (
			01 00 00 00
		)
		// Method begins at RVA 0x4c374
		// Header size: 12
		// Code size: 109 (0x6d)
		.maxstack 4

		// NetworkManager.__rpc_func_table.Add(638792059u, __rpc_handler_638792059);
		IL_0000: ldsfld class [netstandard]System.Collections.Generic.Dictionary`2<uint32, class [Unity.Netcode.Runtime]Unity.Netcode.NetworkManager/RpcReceiveHandler> [Unity.Netcode.Runtime]Unity.Netcode.NetworkManager::__rpc_func_table
		IL_0005: ldc.i4 638792059
		IL_000a: ldnull
		IL_000b: ldftn void ItemDropship::__rpc_handler_638792059(class [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour, valuetype [Unity.Netcode.Runtime]Unity.Netcode.FastBufferReader, valuetype [Unity.Netcode.Runtime]Unity.Netcode.__RpcParams)
		IL_0011: newobj instance void [Unity.Netcode.Runtime]Unity.Netcode.NetworkManager/RpcReceiveHandler::.ctor(object, native int)
		IL_0016: call instance void class [netstandard]System.Collections.Generic.Dictionary`2<uint32, class [Unity.Netcode.Runtime]Unity.Netcode.NetworkManager/RpcReceiveHandler>::Add(!0, !1)
		// NetworkManager.__rpc_func_table.Add(3113622207u, __rpc_handler_3113622207);
		IL_001b: ldsfld class [netstandard]System.Collections.Generic.Dictionary`2<uint32, class [Unity.Netcode.Runtime]Unity.Netcode.NetworkManager/RpcReceiveHandler> [Unity.Netcode.Runtime]Unity.Netcode.NetworkManager::__rpc_func_table
		IL_0020: ldc.i4 -1181345089
		IL_0025: ldnull
		IL_0026: ldftn void ItemDropship::__rpc_handler_3113622207(class [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour, valuetype [Unity.Netcode.Runtime]Unity.Netcode.FastBufferReader, valuetype [Unity.Netcode.Runtime]Unity.Netcode.__RpcParams)
		IL_002c: newobj instance void [Unity.Netcode.Runtime]Unity.Netcode.NetworkManager/RpcReceiveHandler::.ctor(object, native int)
		IL_0031: call instance void class [netstandard]System.Collections.Generic.Dictionary`2<uint32, class [Unity.Netcode.Runtime]Unity.Netcode.NetworkManager/RpcReceiveHandler>::Add(!0, !1)
		// NetworkManager.__rpc_func_table.Add(1496861823u, __rpc_handler_1496861823);
		IL_0036: ldsfld class [netstandard]System.Collections.Generic.Dictionary`2<uint32, class [Unity.Netcode.Runtime]Unity.Netcode.NetworkManager/RpcReceiveHandler> [Unity.Netcode.Runtime]Unity.Netcode.NetworkManager::__rpc_func_table
		IL_003b: ldc.i4 1496861823
		IL_0040: ldnull
		IL_0041: ldftn void ItemDropship::__rpc_handler_1496861823(class [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour, valuetype [Unity.Netcode.Runtime]Unity.Netcode.FastBufferReader, valuetype [Unity.Netcode.Runtime]Unity.Netcode.__RpcParams)
		IL_0047: newobj instance void [Unity.Netcode.Runtime]Unity.Netcode.NetworkManager/RpcReceiveHandler::.ctor(object, native int)
		IL_004c: call instance void class [netstandard]System.Collections.Generic.Dictionary`2<uint32, class [Unity.Netcode.Runtime]Unity.Netcode.NetworkManager/RpcReceiveHandler>::Add(!0, !1)
		// NetworkManager.__rpc_func_table.Add(343429303u, __rpc_handler_343429303);
		IL_0051: ldsfld class [netstandard]System.Collections.Generic.Dictionary`2<uint32, class [Unity.Netcode.Runtime]Unity.Netcode.NetworkManager/RpcReceiveHandler> [Unity.Netcode.Runtime]Unity.Netcode.NetworkManager::__rpc_func_table
		IL_0056: ldc.i4 343429303
		IL_005b: ldnull
		IL_005c: ldftn void ItemDropship::__rpc_handler_343429303(class [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour, valuetype [Unity.Netcode.Runtime]Unity.Netcode.FastBufferReader, valuetype [Unity.Netcode.Runtime]Unity.Netcode.__RpcParams)
		IL_0062: newobj instance void [Unity.Netcode.Runtime]Unity.Netcode.NetworkManager/RpcReceiveHandler::.ctor(object, native int)
		IL_0067: call instance void class [netstandard]System.Collections.Generic.Dictionary`2<uint32, class [Unity.Netcode.Runtime]Unity.Netcode.NetworkManager/RpcReceiveHandler>::Add(!0, !1)
		// }
		IL_006c: ret
	} // end of method ItemDropship::InitializeRPCS_ItemDropship

	.method private hidebysig static 
		void __rpc_handler_638792059 (
			class [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour target,
			valuetype [Unity.Netcode.Runtime]Unity.Netcode.FastBufferReader reader,
			valuetype [Unity.Netcode.Runtime]Unity.Netcode.__RpcParams rpcParams
		) cil managed 
	{
		// Method begins at RVA 0x4c3f0
		// Header size: 12
		// Code size: 69 (0x45)
		.maxstack 2
		.locals init (
			[0] class [Unity.Netcode.Runtime]Unity.Netcode.NetworkManager
		)

		// NetworkManager networkManager = target.NetworkManager;
		IL_0000: ldarg.0
		IL_0001: call instance class [Unity.Netcode.Runtime]Unity.Netcode.NetworkManager [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour::get_NetworkManager()
		IL_0006: stloc 0
		// if ((object)networkManager != null && networkManager.IsListening)
		IL_000a: ldloc 0
		IL_000e: brfalse IL_0021

		IL_0013: ldloc 0
		IL_0017: callvirt instance bool [Unity.Netcode.Runtime]Unity.Netcode.NetworkManager::get_IsListening()
		IL_001c: brtrue IL_0022

		// }
		IL_0021: ret

		// target.__rpc_exec_stage = __RpcExecStage.Server;
		IL_0022: nop
		IL_0023: ldarg.0
		IL_0024: ldc.i4 1
		IL_0029: stfld valuetype [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour/__RpcExecStage [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour::__rpc_exec_stage
		// ((ItemDropship)target).OpenShipServerRpc();
		IL_002e: ldarg.0
		IL_002f: castclass ItemDropship
		IL_0034: callvirt instance void ItemDropship::OpenShipServerRpc()
		// target.__rpc_exec_stage = __RpcExecStage.None;
		IL_0039: ldarg.0
		IL_003a: ldc.i4 0
		IL_003f: stfld valuetype [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour/__RpcExecStage [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour::__rpc_exec_stage
		// (no C# code)
		IL_0044: ret
	} // end of method ItemDropship::__rpc_handler_638792059

	.method private hidebysig static 
		void __rpc_handler_3113622207 (
			class [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour target,
			valuetype [Unity.Netcode.Runtime]Unity.Netcode.FastBufferReader reader,
			valuetype [Unity.Netcode.Runtime]Unity.Netcode.__RpcParams rpcParams
		) cil managed 
	{
		// Method begins at RVA 0x4c444
		// Header size: 12
		// Code size: 69 (0x45)
		.maxstack 2
		.locals init (
			[0] class [Unity.Netcode.Runtime]Unity.Netcode.NetworkManager
		)

		// NetworkManager networkManager = target.NetworkManager;
		IL_0000: ldarg.0
		IL_0001: call instance class [Unity.Netcode.Runtime]Unity.Netcode.NetworkManager [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour::get_NetworkManager()
		IL_0006: stloc 0
		// if ((object)networkManager != null && networkManager.IsListening)
		IL_000a: ldloc 0
		IL_000e: brfalse IL_0021

		IL_0013: ldloc 0
		IL_0017: callvirt instance bool [Unity.Netcode.Runtime]Unity.Netcode.NetworkManager::get_IsListening()
		IL_001c: brtrue IL_0022

		// }
		IL_0021: ret

		// target.__rpc_exec_stage = __RpcExecStage.Client;
		IL_0022: nop
		IL_0023: ldarg.0
		IL_0024: ldc.i4 2
		IL_0029: stfld valuetype [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour/__RpcExecStage [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour::__rpc_exec_stage
		// ((ItemDropship)target).OpenShipClientRpc();
		IL_002e: ldarg.0
		IL_002f: castclass ItemDropship
		IL_0034: callvirt instance void ItemDropship::OpenShipClientRpc()
		// target.__rpc_exec_stage = __RpcExecStage.None;
		IL_0039: ldarg.0
		IL_003a: ldc.i4 0
		IL_003f: stfld valuetype [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour/__RpcExecStage [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour::__rpc_exec_stage
		// (no C# code)
		IL_0044: ret
	} // end of method ItemDropship::__rpc_handler_3113622207

	.method private hidebysig static 
		void __rpc_handler_1496861823 (
			class [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour target,
			valuetype [Unity.Netcode.Runtime]Unity.Netcode.FastBufferReader reader,
			valuetype [Unity.Netcode.Runtime]Unity.Netcode.__RpcParams rpcParams
		) cil managed 
	{
		// Method begins at RVA 0x4c498
		// Header size: 12
		// Code size: 69 (0x45)
		.maxstack 2
		.locals init (
			[0] class [Unity.Netcode.Runtime]Unity.Netcode.NetworkManager
		)

		// NetworkManager networkManager = target.NetworkManager;
		IL_0000: ldarg.0
		IL_0001: call instance class [Unity.Netcode.Runtime]Unity.Netcode.NetworkManager [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour::get_NetworkManager()
		IL_0006: stloc 0
		// if ((object)networkManager != null && networkManager.IsListening)
		IL_000a: ldloc 0
		IL_000e: brfalse IL_0021

		IL_0013: ldloc 0
		IL_0017: callvirt instance bool [Unity.Netcode.Runtime]Unity.Netcode.NetworkManager::get_IsListening()
		IL_001c: brtrue IL_0022

		// }
		IL_0021: ret

		// target.__rpc_exec_stage = __RpcExecStage.Client;
		IL_0022: nop
		IL_0023: ldarg.0
		IL_0024: ldc.i4 2
		IL_0029: stfld valuetype [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour/__RpcExecStage [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour::__rpc_exec_stage
		// ((ItemDropship)target).LandShipClientRpc();
		IL_002e: ldarg.0
		IL_002f: castclass ItemDropship
		IL_0034: callvirt instance void ItemDropship::LandShipClientRpc()
		// target.__rpc_exec_stage = __RpcExecStage.None;
		IL_0039: ldarg.0
		IL_003a: ldc.i4 0
		IL_003f: stfld valuetype [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour/__RpcExecStage [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour::__rpc_exec_stage
		// (no C# code)
		IL_0044: ret
	} // end of method ItemDropship::__rpc_handler_1496861823

	.method private hidebysig static 
		void __rpc_handler_343429303 (
			class [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour target,
			valuetype [Unity.Netcode.Runtime]Unity.Netcode.FastBufferReader reader,
			valuetype [Unity.Netcode.Runtime]Unity.Netcode.__RpcParams rpcParams
		) cil managed 
	{
		// Method begins at RVA 0x4c4ec
		// Header size: 12
		// Code size: 69 (0x45)
		.maxstack 2
		.locals init (
			[0] class [Unity.Netcode.Runtime]Unity.Netcode.NetworkManager
		)

		// NetworkManager networkManager = target.NetworkManager;
		IL_0000: ldarg.0
		IL_0001: call instance class [Unity.Netcode.Runtime]Unity.Netcode.NetworkManager [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour::get_NetworkManager()
		IL_0006: stloc 0
		// if ((object)networkManager != null && networkManager.IsListening)
		IL_000a: ldloc 0
		IL_000e: brfalse IL_0021

		IL_0013: ldloc 0
		IL_0017: callvirt instance bool [Unity.Netcode.Runtime]Unity.Netcode.NetworkManager::get_IsListening()
		IL_001c: brtrue IL_0022

		// }
		IL_0021: ret

		// target.__rpc_exec_stage = __RpcExecStage.Client;
		IL_0022: nop
		IL_0023: ldarg.0
		IL_0024: ldc.i4 2
		IL_0029: stfld valuetype [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour/__RpcExecStage [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour::__rpc_exec_stage
		// ((ItemDropship)target).ShipLeaveClientRpc();
		IL_002e: ldarg.0
		IL_002f: castclass ItemDropship
		IL_0034: callvirt instance void ItemDropship::ShipLeaveClientRpc()
		// target.__rpc_exec_stage = __RpcExecStage.None;
		IL_0039: ldarg.0
		IL_003a: ldc.i4 0
		IL_003f: stfld valuetype [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour/__RpcExecStage [Unity.Netcode.Runtime]Unity.Netcode.NetworkBehaviour::__rpc_exec_stage
		// (no C# code)
		IL_0044: ret
	} // end of method ItemDropship::__rpc_handler_343429303

	.method famorassem hidebysig strict virtual 
		instance string __getTypeName () cil managed 
	{
		// Method begins at RVA 0x4c53d
		// Header size: 1
		// Code size: 6 (0x6)
		.maxstack 8

		// return "ItemDropship";
		IL_0000: ldstr "ItemDropship"
		IL_0005: ret
	} // end of method ItemDropship::__getTypeName

} // end of class ItemDropship
