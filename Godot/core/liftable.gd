class_name Liftable extends Area2D

static var SHADER = preload("res://data/vfx/actor.gdshader")
static var DEATH_FX = preload("res://data/vfx/enemy_death.tres")
static var DROWN_SFX = preload("res://data/sfx/LA_Link_Wade1.wav")
static var DROWN_VFX = preload("res://data/vfx/drown.tres")
static var LAND_SFX = preload("res://data/sfx/LA_Link_Land.wav")
static var KB_TIME = 0.2
static var KB_AMT = 100

@export var speed := 70.0
@export var damage := 5
@export var bouncy := false
@export var break_on_land := false
@export var sprite: Sprite2D
@export var collision: CollisionShape2D

var current_state := state_default
var last_state := state_default
var elapsed_state_time := 0.0
var sprite_direction := "Down"
var move_direction := Vector2.DOWN
var elevation := 0
var rising := true
var carrier: Actor
var carrier_sprite: AnimatedSprite2D

var ray: RayCast2D

signal on_hit
signal carry_position(position: Vector2)
signal throw_position(position: Vector2)


func _ready() -> void:
	ray = RayCast2D.new()
	ray.target_position = Vector2.ZERO
	ray.hit_from_inside = true
	ray.collide_with_areas = true
	ray.set_collision_mask_value(2, true)  # collides with entities
	add_child(ray)

	set_collision_layer_value(1, false)
	set_collision_layer_value(2, true)
	#set_physics_process(false)


func _physics_process(delta: float) -> void:
	_state_process(delta)


# -------------------
# State machine stuff


func _state_process(delta: float) -> void:
	current_state.call()
	last_state = current_state
	elapsed_state_time += delta


func _change_state(new_state) -> void:
	elapsed_state_time = 0
	current_state = new_state


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
	sprite.position.y = -16 + carrier_sprite.position.y

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

# Sets sprite direction to last orthogonal direction.
func _set_direction(vector: Vector2) -> void:
	move_direction = vector


# Plays an animation from a directioned set.
func _play_animation(animation: String) -> void:
	var direction = (
		"Side" if sprite_direction in ["Left", "Right"] else sprite_direction
	)
	sprite.play(animation + direction)
	sprite.flip_h = sprite_direction == "Left"

func _on_body_entered(body) -> void:
	if current_state == state_thrown && body is TileMap:
		if (bouncy):
			move_direction = move_direction.rotated(PI)


func _lift(_carrier: Node2D):
	rising = true
	carrier = _carrier
	carrier_sprite = _carrier.get_node("AnimatedSprite2D")
	_change_state(state_pick_up)


func _throw():
	carrier = null
	carrier_sprite = null
	_change_state(state_thrown)