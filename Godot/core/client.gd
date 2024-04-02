extends Control

@onready var screen = $Screen


func _ready():
	var player = preload("res://data/actors/player/player.tscn").instantiate()
	var dialog = preload("res://core/dialog_box.tscn").instantiate()
	var ui = UI.new(player)
	var overworld_instance = Instance.new(
		"res://data/maps/overworld_1.tscn", player
	)
	screen.add_child(overworld_instance)
	screen.add_child(ui)
	screen.add_child(dialog)
