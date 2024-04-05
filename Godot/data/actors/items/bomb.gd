extends Action

@onready var anim = $AnimationPlayer
@onready var liftable = $Liftable

var target_cell_position: Vector2i:
	get:
		var user_cell = user.position

		match user.sprite_direction:
			"Left":
				return user_cell + Vector2( - 12, 0)
			"Right":
				return user_cell + Vector2(12, 0)
			"Up":
				return user_cell + Vector2(0, -12)
			"Down":
				return user_cell + Vector2(0, 12)
		return user_cell

func _process(_delta):
	pass

func activate(u: Actor) -> void:
	user = u
	actor_type = user.actor_type
	u.on_hit.connect(queue_free)
	position = target_cell_position
	liftable.carry_position.connect(set_position)
	liftable.throw_position.connect(
		func(foo): set_global_position(position + foo)
	)

	anim.play("Bomb")

func _on_explosion_started() -> void:
	$Liftable.queue_free()
	Sound.play(preload ("res://data/sfx/LA_Bomb_Explode.wav"))
	if user.has_method("_on_can_bomb_again"):
		user._on_can_bomb_again.call()
	if user.has_method("_clear_carrying_flag"):
		user._clear_carrying_flag.call()

func _on_explosion_finished() -> void:
	queue_free()

func _on_body_entered(body) -> void:
	if body is Map:
		var cell = body.local_to_map(target_cell_position)
		body.slash(cell)
