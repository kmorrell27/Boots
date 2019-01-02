///@arg size
var _size = argument0;
global.inventory = [];
if (os_browser == browser_not_a_browser) {
	global.inventory[_size - 1] = noone;
} else {
	for (var i = 0; i < _size; i++) {
		global.inventory[i] = noone;
	}
}