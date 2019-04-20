if (room == r_title) {
	exit;
}

var _gui_width = display_get_gui_width();
var _gui_height = display_get_gui_height();
var _health = o_game.save_data_[? o_game.PLAYER_HEALTH];
var _max_health = o_game.save_data_[? o_game.PLAYER_MAX_HEALTH];

if (sprite_exists(paused_sprite_)) {
	draw_sprite_ext(paused_sprite_, 0, 0, 0, paused_sprite_scale_, paused_sprite_scale_, 0, c_white, 1);
	draw_set_alpha(0.6);
	draw_rectangle_color(0, 0, _gui_width, _gui_height, c_black, c_black, c_black, c_black, false);
	draw_set_alpha(1);
}

for (var _i = 0; _i < _max_health; _i++) {
	var _filled = _i < _health; // This is clever
	draw_sprite(s_heart_ui, _filled, (8 * _i) + 4,  4);
}

var _gem_string = string(o_game.save_data_[? o_game.PLAYER_GEMS]);
var _text_width = string_width(_gem_string);

var _x = _gui_width - _text_width + 4;
var _y = _gui_height - 12;

draw_sprite(s_gem, 0, _x - 16, _y + 7);
draw_text(_x - 8, _y - 1, _gem_string);

InventoryDraw(4, 72);