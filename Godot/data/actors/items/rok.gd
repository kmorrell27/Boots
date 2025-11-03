extends Action

@export var speed: int = 120

var velocity: Vector2 = Vector2.ZERO


func _physics_process(delta: float) -> void:
  position += velocity * delta


func activate(u: Actor) -> void:
  user = u
  actor_type = user.actor_type

  position = user.position
  velocity = user.move_direction * speed
