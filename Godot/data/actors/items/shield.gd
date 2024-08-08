extends Action

func activate(u: Actor) -> void:
	user = u
	actor_type = user.actor_type
	user._change_state((user as Player).state_shield)

	Sound.play(preload ("res://data/sfx/LA_Shield.wav"))

func deactivate(_u: Actor) -> void:
	queue_free()
