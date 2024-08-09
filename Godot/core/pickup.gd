class_name Pickup extends Area2D

func _ready() -> void:
	print_debug(self)
	self.area_entered.connect(func(other: Object) -> void: print(other))
	self.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Object) -> void:
	print_debug("Foo")
	if body is Player:
		_pickup()

func _pickup() -> void:
	pass