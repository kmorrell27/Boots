extends Action

@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var liftable: Liftable = $Liftable

var target_cell_position: Vector2i:
	get:
		var user_cell: Vector2 = user.position

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

func _process(_delta: float) -> void:
	pass

func activate(u: Actor) -> void:
	user = u
	actor_type = user.actor_type
	u.on_hit.connect(queue_free)
	position = target_cell_position
	liftable.carry_position.connect(set_position)
	liftable.throw_position.connect(
		func(offset: Vector2) -> void: set_global_position(position + offset)
	)

	anim.play("Bomb")

func _on_explosion_started() -> void:
	$Liftable.queue_free()
	Sound.play(preload ("res://data/sfx/LA_Bomb_Explode.wav"))
	var player: Player = user as Player
	if player != null:
		player._on_can_bomb_again.call()
		player._clear_carrying_flag.call()

func _on_explosion_finished() -> void:
	queue_free()

func _on_body_entered(body: Object) -> void:
	var map: Map = body as Map
	if map != null:
		var cell: Vector2i = map.local_to_map(target_cell_position)
		map.slash(cell)
