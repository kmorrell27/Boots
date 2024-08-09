class_name Pickup extends Area2D

func _ready() -> void:
	set_collision_mask_value(1, false)
	set_collision_mask_value(2, true)
	self.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Object) -> void:
	if body is Player:
		_pickup()

func _pickup() -> void:
	pass