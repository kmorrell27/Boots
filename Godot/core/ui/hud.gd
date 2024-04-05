class_name HUD extends Node2D

const ITEM_B_POSITION = Vector2(8, 0)
const ITEM_A_POSITION = Vector2(48, 0)

var items = {}

func _init():
	scale = Vector2(4, 4)

func _draw():
	if items.get("B"):
		draw_texture(items["B"].icon, ITEM_B_POSITION)
	if items.get("A"):
		draw_texture(items["A"].icon, ITEM_A_POSITION)
