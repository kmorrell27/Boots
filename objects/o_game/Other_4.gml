/// @description Insert description here
// You can write your code in this editor
if (instance_exists(global.player_start_position)) {
		if (instance_exists(o_player)) {
		o_player.persistent = false;
		o_player.x = global.player_start_position.x;
		o_player.y = global.player_start_position.y;
		o_player.layer = layer_get_id("Instances");
	} else {
		var _start_x = global.player_start_position.x;
		var _start_y = global.player_start_position.y;
		instance_create_layer(_start_x, _start_y, "Instances", o_player);
	}
}