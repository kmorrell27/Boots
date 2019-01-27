if (room == r_title) {
	exit;
}

var _gui_width = display_get_gui_width();
var _gui_height = display_get_gui_height();
var _health = ds_map_find_value(o_game.save_data_, o_game.PLAYER_HEALTH);
var _max_health = ds_map_find_value(o_game.save_data_, o_game.PLAYER_MAX_HEALTH);
var _stamina = ds_map_find_value(o_game.save_data_, o_game.PLAYER_STAMINA);
var _max_stamina = ds_map_find_value(o_game.save_data_, o_game.PLAYER_MAX_STAMINA);

if (sprite_exists(paused_sprite_)) {
	draw_sprite_ext(paused_sprite_, 0, 0, 0, paused_sprite_scale_, paused_sprite_scale_, 0, c_white, 1);
	draw_set_alpha(0.6);
	draw_rectangle_color(0, 0, _gui_width, _gui_height, c_black, c_black, c_black, c_black, false);
	draw_set_alpha(1);
}
var _hud_right_edge = max(3 + _max_health * 15, 2 + _max_stamina * 17);
draw_sprite_ext(s_hud, 0, 0, _gui_height, _hud_right_edge, 1, 0, c_white, 1);
draw_sprite(s_hud_edge, 0, _hud_right_edge, _gui_height);

for (var _i = 0; _i < _max_health; _i++) {
	var _filled = _i < _health; // This is clever
	draw_sprite(s_heart_ui, _filled, (15 * _i) + 4, _gui_height - 29);
}

for (var _i = 0; _i < _max_stamina; _i++) {
	var _filled = _i < _stamina; // This is clever
	draw_sprite(s_stamina_ui, _filled, (17 * _i) + 4, _gui_height - 17);
}

var _gem_string = string(ds_map_find_value(o_game.save_data_, o_game.PLAYER_GEMS));
var _text_width = string_width(_gem_string);

var _x = _gui_width - _text_width + 4;
var _y = _gui_height - 12;

draw_sprite(s_gem, 0, _x - 16, _y + 7);
draw_text(_x - 8, _y - 1, _gem_string);

InventoryDraw(4, 36);