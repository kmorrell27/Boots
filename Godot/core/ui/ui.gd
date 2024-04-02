class_name UI extends CanvasLayer

var target
var hud: Node2D
var hearts: Node2D
var inventory: Node2D


func _init(p_target: Actor) -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	visible = true
	target = p_target
	layer = 1
	inventory = Inventory.new()
	inventory.position = Vector2(0, 64)
	hearts = Hearts.new()
	hud = HUD.new()
	hud.position = Vector2.ZERO
	hud.scale = Vector2(4, 4)
	hearts.position = Vector2(4, 4)
	add_child(hud)
	hud.add_child(hearts)
	add_child(inventory)


func _ready():
	_inventory_changed(target.items)
	inventory.connect("inventory_changed", _inventory_changed)


func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		if inventory.visible:
			_close_inventory()
		else:
			_open_inventory()


func _inventory_changed(new_items):
	inventory.items = new_items  # redundant
	target.items = new_items
	hud.items = new_items
	hud.queue_redraw()


func _open_inventory():
	get_tree().paused = true
	Sound.play(preload("res://data/sfx/LA_PauseMenu_Open.wav"))
	await ScreenFX.fade_white_in()
	inventory.show()
	ScreenFX.fade_white_out()


func _close_inventory():
	Sound.play(preload("res://data/sfx/LA_PauseMenu_Close.wav"))
	await ScreenFX.fade_white_in()
	inventory.hide()
	await ScreenFX.fade_white_out()
	get_tree().paused = false
