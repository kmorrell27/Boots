extends Node

enum Doors {
  FOO,
  BAR,
}
enum Chests {
  FOO,
  BAR,
}
enum Keys {
  FOO,
  BAR,
}

var keys: int = 0
var unlocked_doors: Dictionary = { }
var bombed_walls: Dictionary = { }
var opened_chests: Dictionary = { }
