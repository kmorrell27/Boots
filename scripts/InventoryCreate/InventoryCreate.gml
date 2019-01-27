///@arg size
var _size = argument0;
var _inventory = [];
for (var i = 0; i < _size; i++) {
	_inventory[i] = noone;
}

ds_map_replace(o_game.save_data_, o_game.INVENTORY, _inventory);