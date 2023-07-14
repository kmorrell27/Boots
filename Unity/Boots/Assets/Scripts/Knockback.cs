using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Knockback : MonoBehaviour
{
  public float thrust;
  public float knockbackLength;
  public float damage;

  private void OnTriggerEnter2D(Collider2D other)
  {
    if (
      other.gameObject.CompareTag("Enemy")
      || other.gameObject.CompareTag("Player")
    )
    {
      Rigidbody2D hit = other.GetComponent<Rigidbody2D>();
      if (hit == null)
      {
        return;
      }
      // I hate this. I can make this better
      if (other.gameObject.CompareTag("Enemy") && other.isTrigger)
      {
        Enemy enemy = other.GetComponent<Enemy>();
        if (enemy.GetState() == EnemyState.STAGGER)
        {
          // If we're already being knocked back don't take additional damage
          return;
        }
        enemy.SetState(EnemyState.STAGGER);
        enemy.Knock(hit, knockbackLength, damage);
      }
      else if (other.gameObject.CompareTag("Player"))
      {
        PlayerMovement player = other.gameObject.GetComponent<PlayerMovement>();
        if (player.GetState() == PlayerState.STAGGER)
        {
          // Same as above. No double knockbacks!
          return;
        }
        player.SetState(PlayerState.STAGGER);
        player.Knock(knockbackLength, damage);
      }
      Vector2 difference = hit.transform.position - transform.position;
      difference = difference.normalized * thrust;
      hit.AddForce(difference, ForceMode2D.Impulse);
    }
    else if (
      other.gameObject.CompareTag("Breakable")
      && this.gameObject.CompareTag("Player")
    )
    {
      other.GetComponent<Pot>().Smash();
    }
  }
}
