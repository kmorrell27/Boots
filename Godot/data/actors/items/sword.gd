extends Action

const SOUNDS: Array[AudioStreamWAV] = [
  preload("res://data/sfx/LA_Sword_Slash1.wav"),
  preload("res://data/sfx/LA_Sword_Slash2.wav"),
  preload("res://data/sfx/LA_Sword_Slash3.wav"),
  preload("res://data/sfx/LA_Sword_Slash4.wav"),
]

var target_cell_position: Vector2i:
  get:
    var user_cell: Vector2 = user.position.snapped(Vector2(8, 8))

    match user.sprite_direction:
      "Left":
        return user_cell + Vector2(-24, 0)
      "Right":
        return user_cell + Vector2(16, 0)
      "Up":
        return user_cell + Vector2(-8, -16)
      "Down":
        return user_cell + Vector2(0, 16)

    return user_cell

@onready var anim: AnimationPlayer = $AnimationPlayer


func _process(_delta: float) -> void:
  pass


func activate(u: Actor) -> void:
  user = u
  actor_type = user.actor_type
  var player: Player = user as Player
  if player != null:
    player._change_state(player.state_swing)
  user.connect("on_hit", queue_free)
  user.ray.add_exception(self)
  position = user.position

  anim.play(str("Swing", user.sprite_direction))
  Sound.play(SOUNDS[randi() % SOUNDS.size()])


func _on_swing_finished() -> void:
  print_debug("hmmm")
  user._change_state(user.state_default)
  queue_free()


func _on_body_entered(body: Object) -> void:
  var map: Map = body as Map
  if map != null:
    var cell: Vector2 = map.local_to_map(target_cell_position)
    map.slash(cell)
