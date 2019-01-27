/// @description Insert description here
// You can write your code in this editor
var _pos = ds_map_find_value(o_game.save_data_, o_game.PLAYER_START_POSITION);
if (instance_exists(_pos)) {
		if (instance_exists(o_player)) {
		o_player.persistent = false;
		o_player.x = _pos.x;
		o_player.y = _pos.y;
		o_player.layer = layer_get_id("Instances");
	} else {
		var _start_x = _pos.x;
		var _start_y = _pos.y;
		instance_create_layer(_start_x, _start_y, "Instances", o_player);
	}
}