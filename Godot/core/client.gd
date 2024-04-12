extends Control

var overworld: Instance
@onready var screen: SubViewportContainer = $Screen

func _ready() -> void:
	var player: Player = preload ("res://data/actors/player/player.tscn").instantiate()
	var dialog: Control = preload ("res://core/dialog_box.tscn").instantiate()
	var ui: UI = UI.new(player)
	overworld = Instance.new(
		"res://data/maps/overworld_1.tscn", player
	)
	player.vfx.connect(_on_vfx)
	player.use_item.connect(_on_use_item)
	screen.add_child(overworld)
	screen.add_child(ui)
	screen.add_child(dialog)

func _on_vfx(vfx: AnimatedSprite2D) -> void:
	overworld.add_child(vfx)

func _on_use_item(instance: Action, caller: Actor) -> void:
	overworld.add_child(instance)
	instance.activate(caller)
