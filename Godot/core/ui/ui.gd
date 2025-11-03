class_name UI
extends CanvasLayer

var target: Player
var hud: Node2D
var hearts: Hearts


func _init(p_target: Actor) -> void:
  process_mode = Node.PROCESS_MODE_ALWAYS
  visible = true
  target = p_target
  layer = 1
  hearts = Hearts.new()
  hud = HUD.new()
  hud.position = Vector2.ZERO
  hud.scale = Vector2(4, 4)
  hearts.position = Vector2(4, 4)
  add_child(hud)
  hud.add_child(hearts)
  p_target.on_hit.connect(hearts._on_player_health_change)


func _ready() -> void:
  pass


func _process(_delta: float) -> void:
  if Input.is_action_just_pressed("pause"):
    # Pause logic here
    if true:
      pass
    else:
      pass
