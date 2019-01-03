///@arg item
var _item = Singleton(argument0);

var _index = ArrayFindIndex(_item, global.inventory);
if (_index == -1) {
	// That ain't it, Chief
	var _array_size = array_length_1d(global.inventory);
	for (var i = 0; i < _array_size; i++) {
		if (global.inventory[i] == noone) {
			global.inventory[i] = _item;
			return true;
		}
	}
} else {
	return true;
}

// Oh this bit's clever
return false;