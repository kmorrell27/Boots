class_name Player extends Actor

var items = {
	"A": DEF.ITEM.Bomb,
	"B": DEF.ITEM.Feather,
	"X": DEF.ITEM.Arrow,
	"Y": DEF.ITEM.Sword,
	"L": DEF.ITEM.Boots,
	"R": DEF.ITEM.Shield,
}

var input_direction:
	get:
		return Input.get_vector("left", "right", "up", "down")

var elevation := 0.0
var jump_peaked := false
var last_safe_position: Vector2
var drown_instantiated := false
var can_shoot_again := true
var can_bomb_again := true
var carrying: Liftable = null

@onready var shadow: Sprite2D = $Shadow

func _physics_process(delta) -> void:
	_state_process(delta)


func state_default() -> void:
	velocity = input_direction * speed
	move_and_slide()
	_update_sprite_direction(input_direction)
	_check_collisions()

	# Handle animations
	if velocity:
		if (
			is_on_wall()
			and (
				(
					test_move(transform, Vector2.DOWN)
					and sprite_direction == "Down"
				)
				|| (
					test_move(transform, Vector2.UP)
					and sprite_direction == "Up"
				)
				|| (
					test_move(transform, Vector2.RIGHT)
					and sprite_direction == "Right"
				)
				|| (
					test_move(transform, Vector2.LEFT)
					and sprite_direction == "Left"
				)
			)
		):
			_play_animation("Push")
		else:
			_play_animation("Walk")
	else:
		_play_animation("Walk")
		sprite.stop()

	# Handle item usage
	if Input.is_action_just_pressed("a"):
		## First check for liftable
		if carrying:
			if (is_instance_valid(carrying)):
				# A bomb could explode in our hands
				carrying._throw()
			else:
				print_debug("Deal with this %s", carrying)
			carrying = null
		elif _can_lift():
			# This is side-effects :(
			pass
		elif items.get("A") && can_bomb_again:
				_use_item(items["A"].scene)
				can_bomb_again = false
	elif Input.is_action_just_pressed("b") && items.get("B"):
		_use_item(items["B"].scene)
	if Input.is_action_just_pressed("x") && items.get("X"):
		if can_shoot_again:
			_use_item(items["X"].scene)
			can_shoot_again = false
	if Input.is_action_just_pressed("y") && items.get("Y"):
		_use_item(items["Y"].scene)
	elif Input.is_action_just_pressed("l") && items.get("L"):
		current_action_node = _use_item(items["L"].scene)
	elif Input.is_action_just_pressed("r") && items.get("R"):
		_use_item(items["R"].scene)


func state_run() -> void:
	if !Input.is_action_pressed("l"):
		charging = false
		_change_state(state_default)
		return
	# We've come back from jumping or something and want to play
	# the sound again
	if current_action_node == null:
		current_action_node = _use_item(items["L"].scene)
	_play_animation("Walk")
	velocity = input_direction * speed
	if elapsed_state_time > 1 or charging:
		if (
			input_direction != Vector2.ZERO
			and (
				(input_direction.x == 0 and move_direction.x != 0)
				or input_direction.y == 0 and move_direction.y != 0
			)
		):
			charging = false
			# I shouldn't do this but I bet it works
			elapsed_state_time = 0
			return
		else:
			charging = true
			# Always run
			_handle_charging_movement()
	else:
		_update_sprite_direction(input_direction)
	var collided: bool = move_and_slide()
	_check_collisions()
	if collided and elapsed_state_time > 1:
		var run_collision = get_last_slide_collision()
		if run_collision.get_normal() * -1 == move_direction:
			charging = false
			_change_state(state_default)
	# Finally we can jump here. Maybe shield too?
	# I'm gonna abstract out the jump state logic so I don't have to leave
	# the running state
	# Wait maybe that's a bad idea
	if Input.is_action_just_pressed("b") && items.get("B"):
		_use_item(items["B"].scene)


func state_jump() -> void:
	_play_animation("Jump")
	shadow.visible = true
	var jump_speed = 2 if elevation < 6 else 1

	if not jump_peaked:
		if elevation - jump_speed <= 16:
			elevation += jump_speed
		else:
			elevation = 16
			jump_peaked = true
	else:
		# Save this cliff logic somewhere
		#if (!cliff || (cliff && place_free(x, y))) {
		if elevation - jump_speed >= 0:
			elevation -= jump_speed
		else:
			elevation = 0
			jump_peaked = false
			_change_state(state_run if charging else state_default)
			shadow.visible = false
			Sound.play(LAND_SFX)
	sprite.position.y = -elevation
	if charging:
		_handle_charging_movement()
	else:
		velocity = input_direction * speed
	var collided = move_and_slide()
	if collided and charging:
		var run_collision = get_last_slide_collision()
		if run_collision.get_normal() * -1 == move_direction:
			charging = false
	_update_sprite_direction(input_direction)


func state_swing() -> void:
	_play_animation("Swing")


func state_arrow() -> void:
	sprite.stop()
	if elapsed_state_time >= 1:
		_change_state(state_default)


func state_drown() -> void:
	# State init
	if sprite.animation != "SwimDown":
		sprite.animation = "SwimDown"
		sprite.stop()
		Sound.play(DROWN_SFX)

	# Show drown effect. Instance frees itself
	if elapsed_state_time > 0.25:
		sprite.hide()
		_oneshot_vfx(DROWN_VFX)
		_change_state(state_respawning)


func state_respawning() -> void:
	if elapsed_state_time >= 1:
		_respawn()


func _respawn() -> void:
	position = last_safe_position
	sprite.show()
	Sound.play(hit_sfx)
	_change_state(state_default)


func _on_scroll_completed() -> void:
	last_safe_position = position


func _on_can_bomb_again() -> void:
	can_bomb_again = true

func _clear_carrying_flag() -> void:
	carrying = null


func _on_can_shoot_again() -> void:
	can_shoot_again = true

func _can_lift() -> bool:
	if ray.is_colliding():
		var other = ray.get_collider()
		print_debug(other)
		if other is Liftable:
			carrying = other
			other._lift(self)
			return true
	return false


func _handle_charging_movement() -> void:
	velocity = move_direction * speed * 3
	if move_direction.x != 0:
		velocity += Vector2(0, input_direction.y * speed)
	elif move_direction.y != 0:
		velocity += Vector2(input_direction.x * speed, 0)
