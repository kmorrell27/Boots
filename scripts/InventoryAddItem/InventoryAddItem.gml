///@arg item
var _item = Singleton(argument0);
var _inventory = o_game.save_data_[? o_game.INVENTORY];

var _index = ArrayFindIndex(_item, _inventory);
if (_index == -1) {
	// That ain't it, Chief
	var _array_size = array_length_1d(_inventory);
	for (var i = 0; i < _array_size; i++) {
		if (_inventory[i] == noone) {
			_inventory[i] = _item;
			o_game.save_data_[? o_game.INVENTORY] = _inventory;
			return true;
		}
	}
} else {
	return true;
}

// Oh this bit's clever
return false;