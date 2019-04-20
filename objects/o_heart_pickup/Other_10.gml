var _health = o_game.save_data_[? o_game.PLAYER_HEALTH];
_health = clamp(_health + 1, 0, o_game.save_data_[? o_game.PLAYER_MAX_HEALTH]);
o_game.save_data_[? o_game.PLAYER_HEALTH] = _health;
instance_destroy();
audio_play_sound(a_collect_item, 2, false);