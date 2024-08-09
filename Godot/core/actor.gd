@icon("res://editor/svg/Actor.svg")
class_name Actor extends CharacterBody2D

static var SHADER: Shader = preload ("res://data/vfx/actor.gdshader")
static var DEATH_FX: SpriteFrames = preload ("res://data/vfx/enemy_death.tres")
static var DROWN_SFX: AudioStreamWAV = preload ("res://data/sfx/LA_Link_Wade1.wav")
static var DROWN_VFX: SpriteFrames = preload ("res://data/vfx/drown.tres")
static var LAND_SFX: AudioStreamWAV = preload ("res://data/sfx/LA_Link_Land.wav")
static var KB_TIME: float = 0.2
static var KB_AMT: int = 100

@export_enum("Enemy", "Player") var actor_type: String
@export var speed: float = 70.0
@export var hearts: float = 1.0
@export var damage: float = 0.5
@export var hit_sfx: AudioStreamWAV = preload ("res://data/sfx/LA_Enemy_Hit.wav")
@onready var health: float = hearts

var current_action_node: Action = null
var current_state: Callable = state_default
var last_state: Callable = state_default
var elapsed_state_time: float = 0.0
var sprite_direction: String = "Down"
var move_direction: Vector2 = Vector2.DOWN
var charging: bool = false

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D
var ray: RayCast2D

signal on_hit
signal vfx(fx: AnimatedSprite2D)
signal use_item(item: Node, caller: Actor)

func _ready() -> void:
	sprite.material = ShaderMaterial.new()
	(sprite.material as ShaderMaterial).shader = SHADER

	ray = RayCast2D.new()
	ray.target_position = Vector2.ZERO
	ray.hit_from_inside = true
	ray.collide_with_areas = true
	ray.set_collision_mask_value(2, true) # collides with entities
	add_child(ray)

	set_collision_layer_value(1, false)
	set_collision_layer_value(2, true)
	add_to_group("actor")
	#set_physics_process(false)

func _physics_process(delta: float) -> void:
	_state_process(delta)

# -------------------
# State machine stuff

func _state_process(delta: float) -> void:
	current_state.call()
	last_state = current_state
	elapsed_state_time += delta

func _change_state(new_state: Callable) -> void:
	if current_action_node is Action:
		current_action_node.deactivate(self)
		current_action_node = null
	elapsed_state_time = 0
	current_state = new_state

func state_default() -> void:
	pass

func state_hurt() -> void:
	(sprite.material as ShaderMaterial).set_shader_parameter("is_hurt", true)
	move_and_slide()

	if elapsed_state_time > KB_TIME:
		if health <= 0:
			_die()
		else:
			(sprite.material as ShaderMaterial).set_shader_parameter("is_hurt", false)
			_change_state(state_default)

func state_drown() -> void:
	Sound.play(DROWN_SFX)
	_oneshot_vfx(DROWN_VFX)
	queue_free()

# -------------------

func _snap_position() -> void:
	position = position.snapped(Vector2.ONE)

# Sets sprite direction to last orthogonal direction.
func _update_sprite_direction(vector: Vector2) -> void:
	# If the direction we're already going is still valid then don't do anything
	match sprite_direction:
		"Left":
			if vector.x < 0:
				return
		"Right":
			if vector.x > 0:
				return
		"Up":
			if vector.y < 0:
				return
		"Down":
			if vector.y > 0:
				return
	if vector.x < 0:
		move_direction = Vector2.LEFT
		sprite_direction = "Left"
	elif vector.x > 0:
		move_direction = Vector2.RIGHT
		sprite_direction = "Right"
	elif vector.y < 0:
		move_direction = Vector2.UP
		sprite_direction = "Up"
	elif vector.y > 0:
		move_direction = Vector2.DOWN
		sprite_direction = "Down"

# Plays an animation from a directioned set.
func _play_animation(animation: String) -> void:
	var direction: String = (
		"Side" if sprite_direction in ["Left", "Right"] else sprite_direction
	)
	sprite.play(animation + direction)
	sprite.flip_h = sprite_direction == "Left"

func _die() -> void:
	Sound.play(preload ("res://data/sfx/LA_Enemy_Die.wav"))
	_oneshot_vfx(DEATH_FX)
	queue_free()

func _draw() -> void:
	pass

# Instances item and passes self as its user.
func _use_item(item: PackedScene) -> Node:
	var instance: Action = item.instantiate()
	use_item.emit(instance, self)
	return instance

# Returns a random orthogonal direction.
func _get_random_direction() -> Vector2:
	var directions: Array = [Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN]
	return directions[randi() % directions.size()]

func _check_collisions() -> void:
	# Update raycast direction when moving
	if velocity:
		var direction: Vector2 = velocity.normalized()
		ray.position = direction * - 2
		ray.target_position = direction * 4

		if (
			direction.x != 0
			and collision.position.x != direction.x
			and not test_move(transform, Vector2(direction.x, 0))
		):
			collision.position.x = direction.x
		if (
			direction.y != 0
			and collision.position.y != direction.y
			and not test_move(transform, Vector2(0, direction.y))
		):
			collision.position.y = direction.y

	# Handle collisions
	if ray.is_colliding():
		var other: Object = ray.get_collider()

		if other is Map:
			var on_step: String = (other as Map).on_step(self)
			if has_method(on_step):
				call(on_step)
		elif other is Actor or other is Action:
			var actor: Actor = other as Actor
			if actor:
				if actor.actor_type != actor_type and actor.damage > 0:
					_hit(actor.damage, actor.position)

func _oneshot_vfx(frames: SpriteFrames) -> void:
	var new_fx: AnimatedSprite2D = AnimatedSprite2D.new()
	new_fx.animation_finished.connect(new_fx.queue_free)
	new_fx.position = position
	new_fx.sprite_frames = frames
	new_fx.play()
	vfx.emit(new_fx)

# Setup hit state and switch
func _hit(amount: int, pos: Vector2) -> void:
	velocity = (position - pos).normalized() * KB_AMT
	health -= amount
	Sound.play(hit_sfx)
	emit_signal("on_hit", health)
	_change_state(state_hurt)

func drown() -> void:
	_change_state(state_drown)
