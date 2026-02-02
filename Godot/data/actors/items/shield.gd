extends Action


func activate(u: Actor) -> void:
  user = u
  actor_type = user.actor_type
  user._change_state((user as Player).state_shield)
  position = user.position

  Sound.play(preload("res://data/sfx/LA_Shield.wav"))


func deactivate(u: Actor) -> void:
  u.is_defending = false
  queue_free()
