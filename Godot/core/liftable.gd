class_name Liftable
extends Area2D

signal on_hit
signal carry_position(position: Vector2)
signal throw_position(position: Vector2)

@export var bouncy: bool = false
@export var break_on_land: bool = false
@export var sprite: Sprite2D
@export var collision: CollisionShape2D

var current_state: Callable = state_default
var last_state: Callable = state_default
var elapsed_state_time: float = 0.0
var sprite_direction: String = "Down"
var move_direction: Vector2 = Vector2.DOWN
var elevation: int = 0
var rising: bool = true
var carrier: Actor
var carrier_sprite: AnimatedSprite2D
var ray: RayCast2D


func _ready() -> void:
  ray = RayCast2D.new()
  ray.target_position = Vector2.ZERO
  ray.hit_from_inside = true
  ray.collide_with_areas = true
  ray.set_collision_mask_value(2, true) # collides with entities
  add_child(ray)

  set_collision_layer_value(1, false)
  set_collision_layer_value(2, true)
  #set_physics_process(false)


func _physics_process(delta: float) -> void:
  _state_process(delta)


func state_default() -> void:
  pass


func state_pick_up() -> void:
  if elevation < 16:
    elevation += 2
    sprite.position.y = -1 * elevation
  else:
    _change_state(state_carried)


func state_carried() -> void:
  move_direction = carrier.move_direction
  carry_position.emit(carrier.global_position)
  sprite.position.y = -12 + carrier_sprite.position.y


func state_thrown() -> void:
  # move the object
  throw_position.emit(move_direction * 2.5)
  # update the sprite
  if rising:
    if elevation < 24:
      elevation += 2
    else:
      rising = false
  else:
    if elevation > 0:
      elevation -= 2
    else:
      move_direction = Vector2.ZERO
      if break_on_land:
        queue_free()

  sprite.position.y = -1 * elevation
  collision.position.y = -1 * elevation


# -------------------
# State machine stuff
func _state_process(delta: float) -> void:
  current_state.call()
  last_state = current_state
  elapsed_state_time += delta


func _change_state(new_state: Callable) -> void:
  elapsed_state_time = 0
  current_state = new_state


func _on_body_entered(body: Object) -> void:
  if current_state == state_thrown and body is TileMapLayer:
    if (bouncy):
      move_direction = move_direction.rotated(PI)
      elevation = 8
      rising = false
      bouncy = false


func _lift(_carrier: Node2D) -> void:
  rising = true
  carrier = _carrier
  carrier_sprite = _carrier.get_node("AnimatedSprite2D")
  _change_state(state_pick_up)


func _throw() -> void:
  carrier = null
  carrier_sprite = null
  _change_state(state_thrown)
