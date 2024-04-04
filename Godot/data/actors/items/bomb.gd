extends Action

@onready var anim = $AnimationPlayer
@onready var liftable = $Liftable

var target_cell_position: Vector2i:
	get:
		var user_cell = user.position

		match user.sprite_direction:
			"Left":
				return user_cell + Vector2(-12, 0)
			"Right":
				return user_cell + Vector2(12, 0)
			"Up":
				return user_cell + Vector2(0, -12)
			"Down":
				return user_cell + Vector2(0, 12)

		return user_cell


func activate(u: Actor) -> void:
	user = u
	actor_type = user.actor_type
	u.on_hit.connect(queue_free)
	position = target_cell_position
	liftable.carry.connect(set_global_position)

	anim.play("Bomb")
	Sound.play(preload("res://data/sfx/LA_Link_Bounce.wav"))


func _on_explosion_started() -> void:
	Sound.play(preload("res://data/sfx/LA_Bomb_Explode.wav"))
	if user.has_method("_on_can_bomb_again"):
		user._on_can_bomb_again.call()


func _on_explosion_finished() -> void:
	queue_free()


func _process(_delta):
	pass


func _on_body_entered(body) -> void:
	if body is Map:
		var cell = body.local_to_map(target_cell_position)
		body.slash(cell)
