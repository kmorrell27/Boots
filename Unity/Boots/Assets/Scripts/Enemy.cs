using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public enum EnemyState
{
  IDLE,
  WALK,
  ATTACK,
  STAGGER,
}

public class Enemy : MonoBehaviour
{
  private EnemyState currentState;
  public FloatValue maxHealth;
  private float health;
  public string enemyName;
  public int baseAttack;
  public float moveSpeed;

  // Start is called before the first frame update
  protected void Start()
  {
    health = maxHealth.runtimeValue;
  }

  // Update is called once per frame
  void Update() { }

  public EnemyState GetState()
  {
    return currentState;
  }

  public void SetState(EnemyState state)
  {
    if (currentState != state)
    {
      currentState = state;
    }
  }

  public void Knock(
    Rigidbody2D myRigidbody,
    float knockbackLength,
    float damage
  )
  {
    StartCoroutine(KnockCo(myRigidbody, knockbackLength));
    TakeDamage(damage);
  }

  private void TakeDamage(float damage)
  {
    health -= damage;
    if (health <= 0)
    {
      this.gameObject.SetActive(false);
    }
  }

  private IEnumerator KnockCo(Rigidbody2D myRigidBody, float knockbackLength)
  {
    if (myRigidBody == null)
    {
      yield break;
    }
    yield return new WaitForSeconds(knockbackLength);
    myRigidBody.velocity = Vector2.zero;
    myRigidBody.GetComponent<Enemy>().SetState(EnemyState.IDLE);
  }
}
