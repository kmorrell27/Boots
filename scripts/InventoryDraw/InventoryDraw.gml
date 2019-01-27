///@arg x
///@arg y

if (!o_game.paused_) {
	exit;
}

var _x = argument0;
var _y = argument1;

var _inventory = ds_map_find_value(o_game.save_data_, o_game.INVENTORY);
var _array_size = array_length_1d(_inventory);


//Todo-this can be cleaned up.
for (var i = 0; i < _array_size; i++) {
	var _box_x = _x + (i * 32);
	draw_sprite(s_inventory_box, 0, _box_x, _y);
	
	var _item = _inventory[i];
	if (instance_exists(_item)) {
		draw_sprite(_item.sprite_, 0, _box_x + 16, _y + 16);
	}
	
	if (i == item_index_) {
		draw_sprite(s_item_cursor, image_index / 8, _box_x, _y);
		if (instance_exists(_item)) {
			draw_text(_x + 4, _y + 36, _item.description_);
			var _description_height = string_height(_item.description_);
			draw_text(_x + 4, _y + 48 + _description_height,
				"Stamina cost: " +  string(_item.cost_));
		}
	}
}

// TODO- I think I want to draw this even when not paused
draw_sprite(s_inventory_box, 0, 4, 4);
draw_sprite(s_inventory_box, 0, 36, 4);

var _items = ds_map_find_value(o_game.save_data_, o_game.ITEMS);
if (instance_exists(_items[0])) {
	draw_sprite(_items[0].sprite_, 0, 20, 20);
}

if (instance_exists(_items[1])) {
	draw_sprite(_items[1].sprite_, 0, 52, 20);
}