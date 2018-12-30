global.player_health = clamp(global.player_health + 1, 0, global.player_max_health);
instance_destroy();
audio_play_sound(a_collect_item, 2, false);