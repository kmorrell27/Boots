@icon("res://editor/svg/Actor.svg")
class_name Actor
extends CharacterBody2D

signal on_hit

static var SHADER: Shader = preload("res://data/vfx/actor.gdshader")
static var DEATH_FX: SpriteFrames = preload("res://data/vfx/enemy_death.tres")
static var DROWN_SFX: AudioStreamWAV = preload("res://data/sfx/LA_Link_Wade1.wav")
static var DROWN_VFX: SpriteFrames = preload("res://data/vfx/drown.tres")
static var LAND_SFX: AudioStreamWAV = preload("res://data/sfx/LA_Link_Land.wav")
static var KB_TIME: float = 0.2
static var KB_AMT: int = 100

@export_enum("Enemy", "Player") var actor_type: String
@export var speed: float = 70.0
@export var hearts: float = 1.0
@export var damage: float = 0.5
@export var hit_sfx: AudioStreamWAV = preload("res://data/sfx/LA_Enemy_Hit.wav")

var current_action_node: Action = null
var current_state: Callable = state_default
var last_state: Callable = state_default
var elapsed_state_time: float = 0.0
var sprite_direction: String = "Down"
var move_direction: Vector2 = Vector2.DOWN
var charging: bool = false
var ray: RayCast2D
var is_defending: bool = false

@onready var health: float = hearts
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D


func _ready() -> void:
  sprite.material = ShaderMaterial.new()
  (sprite.material as ShaderMaterial).shader = SHADER

  ray = RayCast2D.new()
  ray.target_position = Vector2.ZERO
  ray.hit_from_inside = true
  ray.collide_with_areas = true
  ray.set_collision_mask_value(3 if actor_type == "Player" else 2, true) # collides with entities
  add_child(ray)

  set_collision_layer_value(1, false)
  set_collision_layer_value(2 if actor_type == "Player" else 3, true)
  add_to_group("actor")
  #set_physics_process(false)


func _physics_process(delta: float) -> void:
  _state_process(delta)


func _draw() -> void:
  pass


func state_default(_delta: float) -> void:
  pass


## This should be
func state_knockback(_delta: float) -> void:
  move_and_slide()
  if elapsed_state_time > KB_TIME:
    _change_state(state_default)


func state_hurt(_delta: float) -> void:
  (sprite.material as ShaderMaterial).set_shader_parameter("is_hurt", true)
  move_and_slide()

  if elapsed_state_time > KB_TIME:
    if health <= 0:
      _die()
    else:
      (sprite.material as ShaderMaterial).set_shader_parameter("is_hurt", false)
      _change_state(state_default)


# This should be consolidated
func state_bounce(_delta: float) -> void:
  move_and_slide()

  if elapsed_state_time > KB_TIME:
    _change_state(state_default)


func state_drown(_delta: float) -> void:
  Sound.play(DROWN_SFX)
  _oneshot_vfx(DROWN_VFX)
  queue_free()


func drown() -> void:
  _change_state(state_drown)


# -------------------
# State machine stuff
func _state_process(delta: float) -> void:
  current_state.call(delta)
  last_state = current_state
  elapsed_state_time += delta


func _change_state(new_state: Callable) -> void:
  if current_action_node is Action:
    current_action_node.deactivate(self)
    current_action_node = null
  elapsed_state_time = 0
  current_state = new_state


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
  Sound.play(preload("res://data/sfx/LA_Enemy_Die.wav"))
  _oneshot_vfx(DEATH_FX)
  queue_free()


# Instances item and passes self as its user.
func _use_item(item: PackedScene) -> Node:
  var instance: Action = item.instantiate()
  get_parent().add_child(instance)
  instance.activate(self)
  return instance


# Returns a random orthogonal direction.
func _get_random_direction() -> Vector2:
  var directions: Array = [Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN]
  return directions[randi() % directions.size()]


func _check_collisions(push_timer: float = 0.0) -> void:
  var ray_offset: int = 2
  var ray_length: int = 12
  var collision_offset: int = 1

  # Update raycast direction when moving
  if velocity:
    var direction: Vector2 = velocity.normalized()
    ray.position = direction * -ray_offset
    ray.target_position = direction * ray_length

    if direction.x != 0 and collision.position.x != direction.x and not \
    test_move(transform, Vector2(direction.x, 0)):
      collision.position.x = direction.x * collision_offset
    if direction.y != 0 and collision.position.y != direction.y and not \
    test_move(transform, Vector2(0, direction.y)):
      collision.position.y = direction.y * collision_offset
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
        print(actor)
        if actor.actor_type != actor_type and actor.damage > 0:
          if (is_defending):
            actor.hit(0, position)
            return
          hit(actor.damage, actor.position)
          return
      var action: Action = other as Action
      if action:
        if (action.actor_type != actor_type and action.damage > 0):
          if (is_defending):
            var collision_angle: Vector2 = action.global_position - global_position
            match sprite_direction:
              "Left":
                if (collision_angle.x < 0):
                  _bounce_or_cleanup(action)
                  return
              "Right":
                if (collision_angle.x > 0):
                  _bounce_or_cleanup(action)
                  return
              "Up":
                if (collision_angle.y < 0):
                  _bounce_or_cleanup(action)
                  return
              "Down":
                if (collision_angle.y > 0):
                  _bounce_or_cleanup(action)
                  return
          print("action_damage ", action.damage)
          hit(action.damage, action.position)
          # TODO - Make this a subclass I can check against
          if (action.has_method("cleanup")):
            action.call("cleanup")
          return
    elif (other is LockedDoor):
      (other as LockedDoor).maybe_unlock(self)
    elif (other is Block):
      if (push_timer >= 1):
        (other as Block).maybe_push(self)


func _oneshot_vfx(frames: SpriteFrames) -> void:
  var new_fx: AnimatedSprite2D = AnimatedSprite2D.new()
  new_fx.animation_finished.connect(new_fx.queue_free)
  new_fx.position = position
  new_fx.sprite_frames = frames
  new_fx.play()
  get_parent().add_child(new_fx)


# Setup hit state and switch
func hit(amount: float, pos: Vector2) -> void:
  velocity = (position - pos).normalized() * KB_AMT
  health -= amount
  Sound.play(hit_sfx)
  emit_signal("on_hit", health)
  _change_state(state_hurt if amount > 0 else state_bounce)


func _snap_to_cardinal_direction(vec: Vector2) -> String:
  print(vec)
  if (absf(vec.x) > absf(vec.y)):
    if vec.x > 0:
      return "Right"
    return "Left"
  if vec.y > 0:
    return "Down"
  return "Up"


func _bounce_or_cleanup(action: Action) -> void:
  print("Here")
  if (action.has_method("bounce")):
    action.call("bounce")
    return
  if (action.has_method("cleanup")):
    action.call("cleanup")
    return
