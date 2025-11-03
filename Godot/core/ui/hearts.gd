class_name Hearts
extends Node2D

const HEART_TEXTURE: CompressedTexture2D = preload("res://core/ui/hearts.png")
const HEART_SIZE: Vector2 = Vector2(8, 8)
const ROW_COUNT: int = 7

var hearts: float = 3
var health: float = 3


func _draw() -> void:
  for heart: int in int(hearts):
    var offset_x: int = (heart % ROW_COUNT) * HEART_SIZE.x
    var offset_y: int = floor(heart / ROW_COUNT) * HEART_SIZE.y
    var fraction: int = (health - floor(health)) * 4
    var src_rect: Rect2 = Rect2(fraction * 8, 0, 8, 8)

    if heart < floor(health):
      src_rect = Rect2(32, 0, 8, 8)
    elif heart > floor(health):
      src_rect = Rect2(0, 0, 8, 8)

    draw_texture_rect_region(
      HEART_TEXTURE,
      Rect2(Vector2(offset_x, offset_y), HEART_SIZE),
      src_rect,
    )


func _on_player_health_change(_health: float) -> void:
  health = _health
  queue_redraw()
