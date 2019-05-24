using System;
using System.Linq;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;


public class ClickMgr : MonoBehaviour
{
    public static List<Click> clicks = new List<Click>();

    static void AddNewClicks()
    {
        Func<Click, int, bool> findPressed = 
            (c, bt) => c.mouseButton == bt && c.IsPressed();

        if (Input.GetMouseButtonDown(0) &&
            clicks.Find(c => findPressed(c, 0)) == null)
                clicks.Add(new Click());
        else if (Input.GetMouseButtonDown(1) &&
            clicks.Find(c => findPressed(c, 1)) == null)
                clicks.Add(new Click());
        else if (Input.GetMouseButtonUp(0))
            clicks?.Find(c => findPressed(c, 0))?.Release();
        else if (Input.GetMouseButtonUp(1))
            clicks?.Find(c => findPressed(c, 1))?.Release();
    }

    static List<Click> FindDoubleClicks()
    {
        List<Click> LeftDoubleClicks = clicks.FindAll(c => c.mouseButton == 0 && !c.IsExpired());
        if (LeftDoubleClicks?.Count == 0)
            return LeftDoubleClicks;
        LeftDoubleClicks.RemoveAt(0);
        return LeftDoubleClicks;
    }

    static void RemoveOldClicks()
    {
        clicks.RemoveAll(c => c.IsExpired());
    }
}

public class Click
{
    public double? pressedTime, releasedTime;
    public int mouseButton;
    //public Vector3 position;

    public Click()
    {
        if (Input.GetMouseButtonDown(0))
            mouseButton = 0;
        else if (Input.GetMouseButtonDown(1))
            mouseButton = 1;
        pressedTime = Time.time;
    }

    public void Release()
    {
        releasedTime = Time.time;
    }

    public bool IsPressed()
    {
        return pressedTime != null && releasedTime == null;
    }

    public bool IsExpired()
    {
        Debug.Log($"{releasedTime} - {Time.time}");
        return releasedTime + 0.5 < Time.time;
    }

    public override string ToString()
    {
        string name = mouseButton == 0 ? "left" : "right";
        return $"{name}-click from:{pressedTime} to:{releasedTime}";
    }
}
