class_name Block extends CharacterBody2D

@export var push_count: int = -1

enum State {MOVING, STATIC}

var state: State = State.STATIC
var old_position: Vector2
var new_position: Vector2
var move_timer: float = 0.0

@onready var ray: RayCast2D = $RayCast2D

func _ready() -> void:
	old_position = position

func _process(delta: float) -> void:
	if state == State.MOVING:
		move_timer += delta * 2
		if move_timer > 1:
			move_timer = 1.0
		position = old_position.lerp(new_position, move_timer)
		if position == new_position:
			reset()


func maybe_push(body: Node2D) -> void:
	if (body is Player and push_count != 0 and state == State.STATIC):
		new_position = \
			(body.position - position).snapped(Vector2(16, 16)) * -1
		ray.target_position = new_position
		ray.force_raycast_update()
		if not ray.is_colliding():
			new_position = new_position + position
			state = State.MOVING
			(body as Player).push_timer = 0
	if (push_count > 0):
		push_count -= 1


func reset() -> void:
	old_position = position
	new_position = Vector2.ZERO
	state = State.STATIC
	move_timer = 0
