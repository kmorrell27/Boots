event_user(state_);
sprite_index = sprite_[state_, facing_];
depth = -y;

if (ds_map_find_value(o_game.save_data_, o_game.PLAYER_HEALTH) <= 0 && !invincible_) {
	instance_destroy();
}