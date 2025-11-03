extends Actor

const ROK_PROJECTILE: PackedScene = preload("res://data/actors/items/rok.tscn")

@export var move_time: float = 1.0
@export var wait1_time: float = 1.0
@export var wait2_time: float = 1.0

var original_position: Vector2


func _enter_tree() -> void:
  # This feels like something I should make a util
  original_position = global_position


func state_default(_delta: float) -> void:
  move_direction = _get_random_direction()
  _change_state(state_move)


func state_move(_delta: float) -> void:
  if is_on_wall():
    move_direction = -move_direction
    original_position == global_position

  velocity = move_direction * speed
  move_and_slide()

  _check_collisions()
  _update_sprite_direction(move_direction)
  _play_animation("Walk")
  sprite.flip_v = (sprite_direction == "Up")

  if elapsed_state_time > move_time:
    _change_state(state_wait1)


func state_wait1(_delta: float) -> void:
  sprite.stop()
  _check_collisions()
  if elapsed_state_time > wait1_time:
    _use_item(ROK_PROJECTILE)
    _change_state(state_wait2)


func state_wait2(_delta: float) -> void:
  _check_collisions()
  if elapsed_state_time > wait2_time:
    _change_state(state_default)
