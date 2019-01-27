var _health = ds_map_find_value(o_game.save_data_, o_game.PLAYER_HEALTH);
_health = clamp(_health + 1, 0, ds_map_find_value(o_game.save_data_, o_game.PLAYER_MAX_HEALTH));
ds_map_replace(o_game.save_data_, o_game.PLAYER_HEALTH, _health);
instance_destroy();
audio_play_sound(a_collect_item, 2, false);