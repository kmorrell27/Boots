extends Pickup

func _pickup() -> void:
	Inventory.keys += 1
	queue_free()