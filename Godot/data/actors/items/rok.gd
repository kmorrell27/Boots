extends Action

@export var speed: int = 120

var velocity: Vector2 = Vector2.ZERO
var bounced: bool = false


func _physics_process(delta: float) -> void:
  position += velocity * delta


func activate(u: Actor) -> void:
  user = u
  actor_type = user.actor_type

  position = user.position
  velocity = user.move_direction * speed


func cleanup() -> void:
  queue_free()


func bounce() -> void:
  if (!bounced):
    velocity = velocity * -1
    bounced = true
