extends TileMap

func _ready():
	# The size of our cell
	var size = tile_set.tile_size
	var offset = size / 2
	# Find every tile in the tilemap and their cell position
	for tile in get_used_cells(0):
		print_debug(tile)
		# Get the name of the tile in the tileset based in the coordinates
		var name = 'stalfos'
		# Take a enemy scene by his name in the enemies folder and create a instance
		var node = load(str('res://enemies/', name, '.tscn')).instantiate()
		# Calculates the position that the tile will be placed
		node.global_position = tile * size + offset
		# Just add the node
		get_parent().call_deferred("add_child", node)
	# Delete the tileset
	super.queue_free()
