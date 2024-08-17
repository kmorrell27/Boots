class_name LockedDoor extends StaticBody2D

@onready var anim: AnimationPlayer = $AnimationPlayer

func maybe_unlock(body: Node2D) -> void:
	if (body is Player and Inventory.keys > 0):
		Inventory.keys -= 1
		anim.play("Unlock")

func _on_animation_finish() -> void:
	queue_free()