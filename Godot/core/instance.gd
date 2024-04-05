class_name Instance extends SubViewport

var map: Map
var player: Actor
var camera: GridCamera

func _init(map_path: String, p_player: Actor):
	map = load(map_path).instantiate()
	var spawn: Node2D = map.get_node("Spawn")
	camera = GridCamera.new()
	player = p_player
	player.position = spawn.position
	canvas_item_default_texture_filter = (
		Viewport.DEFAULT_CANVAS_ITEM_TEXTURE_FILTER_NEAREST
	)

func _enter_tree():
	add_child(map)
	add_child(camera)
	camera.target = player
	map.add_child(player)
