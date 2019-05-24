using System;
using System.Linq;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class KeyMgr : MonoBehaviour
{
    static List<KeyCode> keysDn = new List<KeyCode>();
    static List<KeyCode> keysUp = new List<KeyCode>();
    static List<Key> keys = new List<Key>();

    public static List<KeyCode> GetKeys()
    {
        List<KeyCode> keys = new List<KeyCode>();
        foreach (KeyCode k in Key.keyCodes)
            if (Input.GetKey(k))
                keys.Add(k);
        return keys;
    }

    public static List<KeyCode> GetKeysReleased()
    {
        var keys = GetKeys();
        List<KeyCode> released = new List<KeyCode>();
        foreach (KeyCode k in keysDn)
            if (!keys.Contains(k))
                released.Add(k);
        return released;
    }

    void Update()
    {
        DnKeys();
        UpKeys();
        RemoveExpiredKeys();
        Output($" - ", keys);
    }

    static void DnKeys()
    {
        keysDn = GetKeys();
        foreach (KeyCode k in keysDn)
            if (!keys.Any(key => key.keyCode == k))
                keys.Add(new Key(k));
    }

    static void UpKeys()
    {
        keysUp = GetKeysReleased();
        foreach (KeyCode k in keysDn)
            keys?.Find(key => key.keyCode == k && key.IsPressed())?.Release();
    }

    static void RemoveExpiredKeys()
    {
        keys.RemoveAll(k => k.IsExpired());
    }

    static void Output<T>(string debug, List<T> keys)
    {
        foreach (T k in keys)
            debug += $"{k.ToString()} ";
        Debug.Log(debug);
    }
}


public class Key
{
    public double? pressedTime, releasedTime;
    public KeyCode keyCode;
    public static IEnumerable<KeyCode> keyCodes = Enum.GetValues(typeof(KeyCode)).Cast<KeyCode>();

    public Key(KeyCode keyCode)
    {
        this.keyCode = keyCode;
        pressedTime = Time.time;
        releasedTime = null;
    }

    public void Release()
    {
        Debug.Log($"Release");
        if (IsPressed())
            releasedTime = Time.time;
    }

    public bool IsPressed()
    {
        return pressedTime != null && releasedTime == null;
    }

    public bool IsExpired()
    {
        Debug.Log($"{keyCode}");
        return releasedTime + 0.5 < Time.time;
    }

    public override string ToString()
    {
        string keyName = keyCode.ToString();
        return $"{keyName}";
    }
}
