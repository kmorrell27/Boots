extends Action

static var TINK_SFX: AudioStreamWAV = preload ("res://data/sfx/LA_Sword_Tap.wav")
@export var speed: int = 240
@export var fall_speed: int = 20
var velocity: Vector2 = Vector2.ZERO

@onready var anim: AnimationPlayer = $AnimationPlayer

signal on_hit

func _physics_process(delta: float) -> void:
	position += velocity * delta

func activate(u: Actor) -> void:
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

func _on_body_entered(body: Object) -> void:
	set_deferred("monitoring", false)
	(user as Player)._on_can_shoot_again.call()
	emit_signal("on_hit")
	if body is TileMap:
		_hit_wall()
	elif body is CollisionObject2D:
		emit_signal("on_hit")
		queue_free()

func _hit_wall() -> void:
	velocity = Vector2.DOWN * fall_speed
	Sound.play(TINK_SFX)
	anim.play("wall_hit")
