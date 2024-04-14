@icon("res://editor/svg/Map.svg")
@tool
class_name Map extends TileMap

enum Layer {STATIC, DYNAMIC}

func on_step(actor: Actor) -> String:
	var data: TileData = get_cell_tile_data(Layer.STATIC, local_to_map(actor.position))

	if data:
		return data.get_custom_data("on_step")

	return ""

#
func slash(cell: Vector2i) -> void:
	var data: TileData = get_cell_tile_data(Layer.DYNAMIC, cell)

	if data and data.get_custom_data("is_cuttable"):
		var cut_fx: Node2D = preload ("res://core/vfx/grass_cut.tscn").instantiate()

		cut_fx.position = map_to_local(cell)
		add_child(cut_fx)
		erase_cell(Layer.DYNAMIC, cell)
