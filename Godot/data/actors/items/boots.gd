extends Action

var sound: int


func activate(u: Actor) -> void:
  user = u
  actor_type = user.actor_type
  user._change_state((user as Player).state_run)

  sound = Sound.play(preload("res://data/sfx/LA_Link_Run.wav"))


func deactivate(_u: Actor) -> void:
  Sound.stop(sound)
  queue_free()
