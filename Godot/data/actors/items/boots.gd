extends Action

var sound: int

func activate(u) -> void:
	user = u
	user._change_state(user.state_run)

	sound = Sound.play(preload ("res://data/sfx/LA_Link_Run.wav"))

func deactivate(_u: Actor) -> void:
	Sound.stop(sound)
	queue_free()
