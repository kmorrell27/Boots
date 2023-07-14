using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Log : Enemy
{
  Rigidbody2D myRigidBody;
  public Transform target;
  public float chaseRadius;
  public float attackRadius;
  public Animator anim;

  // Start is called before the first frame update
  protected new void Start()
  {
    base.Start();
    myRigidBody = GetComponent<Rigidbody2D>();
    target = GameObject.FindWithTag("Player").transform;
    anim = GetComponent<Animator>();
  }

  // Update is called once per frame
  void FixedUpdate()
  {
    CheckDistance();
  }

  private void SetAnim(Vector2 direction)
  {
    anim.SetFloat("moveX", direction.x);
    anim.SetFloat("moveY", direction.y);
  }

  private void ChangeAnim(Vector2 direction)
  {
    if (Mathf.Abs(direction.x) > Mathf.Abs(direction.y))
    {
      if (direction.x > 0)
      {
        SetAnim(Vector2.right);
      }
      else if (direction.x < 0)
      {
        SetAnim(Vector2.left);
      }
    }
    else if (Mathf.Abs(direction.x) < Mathf.Abs(direction.y))
    {
      if (direction.y > 0)
      {
        SetAnim(Vector2.up);
      }
      else if (direction.y < 0)
      {
        SetAnim(Vector2.down);
      }
    }
    else { }
  }

  void CheckDistance()
  {
    if (GetState() == EnemyState.STAGGER)
    {
      // Don't do anyhing if we're staggered
      return;
    }
    float distance = Vector3.Distance(target.position, transform.position);
    if (
      distance <= chaseRadius
      && distance > attackRadius
      // This is ugly
      && (GetState() == EnemyState.IDLE || GetState() == EnemyState.WALK)
    )
    {
      Vector3 movement = Vector3.MoveTowards(
        transform.position,
        target.position,
        moveSpeed * Time.deltaTime
      );
      ChangeAnim(movement - transform.position);
      myRigidBody.MovePosition(movement);
      SetState(EnemyState.WALK);
      anim.SetBool("wakeUp", true);
    }
    else
    {
      SetState(EnemyState.IDLE);
      anim.SetBool("wakeUp", false);
    }
  }
}
