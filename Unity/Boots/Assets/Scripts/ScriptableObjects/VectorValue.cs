using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu]
public class VectorValue : ScriptableObject, ISerializationCallbackReceiver
{
  public Vector2 initialValue;

  [HideInInspector]
  public Vector2 runtimeValue;

  public void OnBeforeSerialize() { }

  public void OnAfterDeserialize()
  {
    Debug.Log("---");
    Debug.Log(initialValue);
    runtimeValue = initialValue;
  }
}
