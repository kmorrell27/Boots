extends Action

static var TINK_SFX = preload ("res://data/sfx/LA_Sword_Tap.wav")
@export var speed = 240
@export var fall_speed = 20
var velocity := Vector2.ZERO

@onready var anim := $AnimationPlayer

signal on_hit

func _physics_process(delta):
	position += velocity * delta

func activate(u) -> void:
	user = u
	actor_type = user.actor_type

	position = user.position
	match user.move_direction:
		Vector2.LEFT:
			rotate(deg_to_rad(90))
		Vector2.UP:
			rotate(deg_to_rad(180))
		Vector2.RIGHT:
			rotate(deg_to_rad(270))
		Vector2.DOWN:
			pass
	velocity = user.move_direction * speed

func _on_body_entered(body):
	set_deferred("monitoring", false)
	if user.has_method("_on_can_shoot_again"):
		user._on_can_shoot_again.call()
	emit_signal("on_hit")
	if body is TileMap:
		_hit_wall()
	elif body is CollisionObject2D:
		emit_signal("on_hit")
		queue_free()

func _hit_wall():
	velocity = Vector2.DOWN * fall_speed
	Sound.play(TINK_SFX)
	anim.play("wall_hit")
