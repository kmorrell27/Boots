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
