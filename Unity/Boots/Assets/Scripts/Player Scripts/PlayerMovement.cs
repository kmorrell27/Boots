using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public enum PlayerState
{
  WALK,
  ATTACK,
  INTERACT,
  STAGGER,
  IDLE
}

public class PlayerMovement : MonoBehaviour
{
  private PlayerState currentState;
  public float speed;
  private Rigidbody2D myRigidbody;
  private Vector2 change;
  private Animator animator;
  public FloatValue currentHealth;
  public SignalEmitter playerHealthSignal;
  public VectorValue startingPosition;

  // Start is called before the first frame update
  void Start()
  {
    currentState = PlayerState.WALK;
    animator = GetComponent<Animator>();
    myRigidbody = GetComponent<Rigidbody2D>();
    // So it knows I'm facing down
    animator.SetFloat("moveX", 0);
    animator.SetFloat("moveY", -1);
    transform.position = startingPosition.runtimeValue;
    Debug.Log(startingPosition.runtimeValue);
  }

  // Update is called once per frame
  void Update()
  {
    change = Vector2.zero;
    change.x = Input.GetAxisRaw("Horizontal");
    change.y = Input.GetAxisRaw("Vertical");
    if (Input.GetButtonDown("attack") && CanAttack())
    {
      StartCoroutine(AttackCo());
    }
    else if (CanWalk())
    {
      UpdateAnimationAndMove();
    }
  }

  private IEnumerator AttackCo()
  {
    animator.SetBool("attacking", true);
    currentState = PlayerState.ATTACK;
    yield return null;
    animator.SetBool("attacking", false);
    yield return new WaitForSeconds(.3f);
    currentState = PlayerState.WALK;
  }

  void MoveCharacter()
  {
    Vector2 position = transform.position;
    change = change.normalized;
    myRigidbody.MovePosition(position + change * speed * Time.deltaTime);
  }

  public void Knock(float knockbackLength, float damage)
  {
    currentHealth.runtimeValue -= damage;
    if (currentHealth.runtimeValue > 0)
    {
      playerHealthSignal.Emit();
      StartCoroutine(KnockCo(knockbackLength));
    }
    else
    {
      this.gameObject.SetActive(false);
    }
  }

  private IEnumerator KnockCo(float knockbackLength)
  {
    if (myRigidbody == null)
    {
      yield break;
    }
    yield return new WaitForSeconds(knockbackLength);
    myRigidbody.velocity = Vector2.zero;
    currentState = PlayerState.IDLE;
  }

  void UpdateAnimationAndMove()
  {
    if (change != Vector2.zero)
    {
      MoveCharacter();
      animator.SetBool("moving", true);
      // This is probably more complicated than it needs to be but I don't want
      // the animation to change more than is necessary
      float currentX = animator.GetFloat("moveX");
      float currentY = animator.GetFloat("moveY");
      if (
        (currentX < 0 && change.x < 0)
        || (currentX > 0 && change.x > 0)
        || (currentY < 0 && change.y < 0)
        || (currentY > 0 && change.y > 0)
      )
      {
        // jk ignore the comment above this is sick
        return;
      }
      animator.SetFloat("moveX", change.x);
      animator.SetFloat("moveY", change.y);
    }
    else
    {
      animator.SetBool("moving", false);
    }
  }

  public PlayerState GetState()
  {
    return currentState;
  }

  private bool CanAttack()
  {
    return currentState != PlayerState.ATTACK
      && currentState != PlayerState.STAGGER;
  }

  private bool CanWalk()
  {
    return currentState == PlayerState.IDLE || currentState == PlayerState.WALK;
  }

  public void SetState(PlayerState state)
  {
    if (currentState != state)
    {
      currentState = state;
    }
  }
}
