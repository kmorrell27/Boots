class_name Instance
extends SubViewport

var map: Map
var player: Actor
var camera: GridCamera


func _init(map_path: String, p_player: Actor) -> void:
  map = (load(map_path) as PackedScene).instantiate()
  var spawn: Node2D = map.get_node("Spawn")
  camera = GridCamera.new()
  camera.scroll_started.connect(_on_camera_scroll_started)
  camera.scroll_completed.connect(_on_camera_scroll_completed)
  player = p_player
  player.position = spawn.position
  canvas_item_default_texture_filter = (
    Viewport.DEFAULT_CANVAS_ITEM_TEXTURE_FILTER_NEAREST
  )


func _enter_tree() -> void:
  add_child(map)
  add_child(camera)
  camera.target = player
  map.add_child(player)
  _on_camera_scroll_started()
  _on_camera_scroll_completed()


func _on_camera_scroll_started() -> void:
  for actor: Actor in get_tree().get_nodes_in_group("actor"):
    actor.set_physics_process(false)
    actor.sprite.stop()


func _on_camera_scroll_completed() -> void:
  for actor: Actor in get_tree().get_nodes_in_group("actor"):
    if camera.world_to_grid(actor.position) == camera.grid_position:
      actor.set_physics_process(true)
  for node: Node2D in get_tree().get_nodes_in_group("resettable"):
    node.call("_reset")
