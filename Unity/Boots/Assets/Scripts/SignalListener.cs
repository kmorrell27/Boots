using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

public class SignalListener : MonoBehaviour
{
  public SignalEmitter signal;
  public UnityEvent signalEvent;

  public void OnSignalEmitted()
  {
    signalEvent.Invoke();
  }

  private void OnEnable()
  {
    signal.RegisterListener(this);
  }

  private void OnDisable()
  {
    signal.UnregisterListener(this);
  }
}
