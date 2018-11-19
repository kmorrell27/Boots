/// @description Insert description here
// You can write your code in this editor
if (instance_exists(global.player_start_position) && instance_exists(o_player)) {
	o_player.persistent = false;
	o_player.x = global.player_start_position.x;
	o_player.y = global.player_start_position.y;
}