extends Control

var overworld: Instance
@onready var screen = $Screen

func _ready():
	var player := preload ("res://data/actors/player/player.tscn").instantiate()
	var dialog = preload ("res://core/dialog_box.tscn").instantiate()
	var ui = UI.new(player)
	overworld = Instance.new(
		"res://data/maps/overworld_1.tscn", player
	)
	player.vfx.connect(_on_vfx)
	player.use_item.connect(_on_use_item)
	screen.add_child(overworld)
	screen.add_child(ui)
	screen.add_child(dialog)

func _on_vfx(vfx: AnimatedSprite2D):
	overworld.add_child(vfx)

func _on_use_item(instance: Node, caller: Actor):
	overworld.add_child(instance)
	instance.activate(caller)