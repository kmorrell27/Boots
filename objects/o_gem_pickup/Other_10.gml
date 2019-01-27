var _gems = ds_map_find_value(o_game.save_data_, o_game.PLAYER_GEMS);
_gems++;
ds_map_replace(o_game.save_data_, o_game.PLAYER_GEMS, _gems);
instance_destroy();
audio_play_sound(a_collect_item, 2, false);