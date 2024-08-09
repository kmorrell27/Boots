extends Action

func activate(u: Actor) -> void:
	user = u
	actor_type = user.actor_type
	user._change_state((user as Player).state_jump)

	Sound.play(preload ("res://data/sfx/LA_Link_Jump.wav"))
	queue_free()
