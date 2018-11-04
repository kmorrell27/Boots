if (!instance_exists(o_player)) {
	exit;
}

var _player_distance = point_distance(x, y, o_player.x, o_player.y);
if (_player_distance < 16) {
	state_ = PorcupineState.ATTACK;
	image_index = 0;
	sprite_index= s_porcupine_attack;
}