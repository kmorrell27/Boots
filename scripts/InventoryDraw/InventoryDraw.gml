///@arg x
///@arg y

if (!o_game.paused_) {
	exit;
}

var _x = argument0;
var _y = argument1;

var _array_size = array_length_1d(global.inventory);


//Todo-this can be cleaned up.
for (var i = 0; i < _array_size; i++) {
	var _box_x = _x + (i * 32);
	draw_sprite(s_inventory_box, 0, _box_x, _y);
	
	var _item = global.inventory[i];
	if (instance_exists(_item)) {
		draw_sprite(_item.sprite_, 0, _box_x + 16, _y + 16);
	}
	
	if (i == item_index_) {
		draw_sprite(s_item_cursor, image_index / 8, _box_x, _y);
	}
}