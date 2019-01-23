// Game variables
global.one_second = game_get_speed(gamespeed_fps);

// Oho is this bad
global.destroyed = [];

instance_create_layer(0, 0, "Instances", o_input);

var _font_string = "ABCDEFGHIJKLMNOPQRSTUVWXYZ.abcdefghijklmnopqrstuvwxyz1234567890>,!':-+";
global.font = font_add_sprite_ext(s_font, _font_string, true, 1);
draw_set_font(global.font);

//Player variables
global.player_max_health = 3;
global.player_health = global.player_max_health;
global.player_max_stamina = 3;
global.player_stamina = global.player_max_stamina;
global.player_gems = 0;
global.player_start_position = i_game_start;

//audio_play_sound(a_music, 10, true);
display_set_gui_size(camera_get_view_width(view_camera[0]),
	camera_get_view_height(view_camera[0]));
	
paused_ = false;
paused_sprite_ = noone;
paused_sprite_scale_ = display_get_gui_width() / view_wport[0];

global.item[0] = noone;
global.item[1] = noone;
item_index_ = 0;
InventoryCreate(6);
InventoryAddItem(o_ring_item);
InventoryAddItem(o_sword_item);
InventoryAddItem(o_bomb_item);