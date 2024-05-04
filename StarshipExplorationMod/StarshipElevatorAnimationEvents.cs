using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class StarshipElevatorAnimationEvents : MonoBehaviour
{
    public Action<bool>? onElevatorStops;
    private Animator? anim;

    private void Start()
    {
        anim = GetComponent<Animator>();
    }
    public void ElevatorStops()
    {
        if(anim == null) return;

        Debug.Log("-------------- Elevator Stop Animation Event Triggered");
        onElevatorStops?.Invoke(anim.GetBool("Down"));
    }
}
