class_name Pickup extends Area2D

@export var sprite: Sprite2D

func _ready() -> void:
	self.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Object) -> void:
	if body is Player:
		_pickup()

func _pickup() -> void:
	pass