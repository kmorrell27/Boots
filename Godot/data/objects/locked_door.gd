class_name LockedDoor extends StaticBody2D

func maybe_unlock(body: Node2D) -> void:
	if (body is Player and Inventory.keys > 0):
		Inventory.keys -= 1
		queue_free()