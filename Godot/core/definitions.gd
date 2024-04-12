extends Node

class ItemEntry:
	var scene: PackedScene
	var name: String
	var icon: Texture2D
	var description: String = "An item"

	func _init(resource: ItemResource) -> void:
		scene = resource.scene
		name = resource.name
		icon = resource.icon
		description = resource.description

var ITEM: Dictionary = {
	Boots = ItemEntry.new(preload ("res://core/ui/items/boots.tres")),
	Bomb = ItemEntry.new(preload ("res://core/ui/items/bomb.tres")),
	Arrow = ItemEntry.new(preload ("res://core/ui/items/arrow.tres")),
	Feather = ItemEntry.new(preload ("res://core/ui/items/feather.tres")),
	Shield = ItemEntry.new(preload ("res://core/ui/items/shield.tres")),
	Sword = ItemEntry.new(preload ("res://core/ui/items/sword.tres")),
}
