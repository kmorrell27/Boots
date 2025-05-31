extends Control

var overworld: Instance
@onready var screen: SubViewportContainer = $Screen

func _ready() -> void:
	var player: Player = preload("res://data/actors/player/player.tscn").instantiate()
	var dialog: Control = preload("res://core/dialog_box.tscn").instantiate()
	var ui: UI = UI.new(player)
	overworld = Instance.new(
		"res://data/maps/Dungeon 1.tscn", player
	)
	screen.add_child(overworld)
	screen.add_child(ui)
	screen.add_child(dialog)