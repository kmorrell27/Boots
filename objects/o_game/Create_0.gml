// Constants
PLAYER_MAX_HEALTH = "player_max_health";
PLAYER_HEALTH = "player_health";
PLAYER_GEMS = "player_gems";
PLAYER_START_POSITION = "player_start_position";
DESTROYED = "destroyed";
ITEMS = "items";
INVENTORY = "inventory";

// Game variables
global.one_second = game_get_speed(gamespeed_fps);
file_name_ = "SaveData.sav";

instance_create_layer(0, 0, "Instances", o_input);

var _font_string = "ABCDEFGHIJKLMNOPQRSTUVWXYZ.abcdefghijklmnopqrstuvwxyz1234567890>,!':-+";
global.font = font_add_sprite_ext(s_font, _font_string, true, 1);
draw_set_font(global.font);

save_data_ = ds_map_create();

// World variables
ds_map_add_map(save_data_, DESTROYED, ds_map_create());

// Player variables
save_data_[? PLAYER_MAX_HEALTH] = 3;
save_data_[? PLAYER_HEALTH] = 3;
save_data_[? PLAYER_GEMS] = 0;
save_data_[? PLAYER_START_POSITION] = noone;
save_data_[? ITEMS] = [noone, noone];

//audio_play_sound(a_music, 10, true);
display_set_gui_size(camera_get_view_width(view_camera[0]),
	camera_get_view_height(view_camera[0]));
	
paused_ = false;
paused_sprite_ = noone;
paused_sprite_scale_ = display_get_gui_width() / view_wport[0];

item_index_ = 0;
InventoryCreate(6);
InventoryAddItem(o_ring_item);
InventoryAddItem(o_bow_item);
InventoryAddItem(o_fire_rod_item);

enum Transition {
    LEFT,
    RIGHT,
    UP,
    DOWN,
	NONE,
}