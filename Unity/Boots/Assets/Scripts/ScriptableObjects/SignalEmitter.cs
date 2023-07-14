using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu]
public class SignalEmitter : ScriptableObject
{
  public List<SignalListener> listeners = new List<SignalListener>();
  private Dictionary<int, SignalListener> listenersDict =
    new Dictionary<int, SignalListener>();

  public void Awake()
  {
    foreach (SignalListener listener in listeners)
    {
      listenersDict[listener.GetInstanceID()] = listener;
    }
  }

  public void Emit()
  {
    foreach (SignalListener listener in listenersDict.Values)
    {
      listener.OnSignalEmitted();
    }
  }

  public void RegisterListener(SignalListener listener)
  {
    listenersDict[listener.GetInstanceID()] = listener;
  }

  public void UnregisterListener(SignalListener listener)
  {
    listenersDict.Remove(listener.GetInstanceID());
  }
}
