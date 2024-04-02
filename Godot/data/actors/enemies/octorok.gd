extends Actor

const ROK_PROJECTILE = preload("res://data/actors/items/rok.tscn")

@export var move_time: float = 1.0
@export var wait1_time: float = 1.0
@export var wait2_time: float = 1.0


func state_default() -> void:
	move_direction = _get_random_direction()
	_change_state(state_move)


func state_move() -> void:
	if is_on_wall():
		move_direction = -move_direction

	velocity = move_direction * speed
	move_and_slide()

	_check_collisions()
	_update_sprite_direction(move_direction)
	_play_animation("Walk")
	sprite.flip_v = (sprite_direction == "Up")

	if elapsed_state_time > move_time:
		_change_state(state_wait1)


func state_wait1() -> void:
	sprite.stop()
	_check_collisions()
	if elapsed_state_time > wait1_time:
		_use_item(ROK_PROJECTILE)
		_change_state(state_wait2)


func state_wait2() -> void:
	_check_collisions()
	if elapsed_state_time > wait2_time:
		_change_state(state_default)
