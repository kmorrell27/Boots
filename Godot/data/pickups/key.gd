extends Pickup

func _pickup() -> void:
	print_debug("Hi!")
	Inventory.keys += 1
	queue_free()