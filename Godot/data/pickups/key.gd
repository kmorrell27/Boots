extends Pickup

func _pickup() -> void:
	Global.keys += 1
	queue_free()
