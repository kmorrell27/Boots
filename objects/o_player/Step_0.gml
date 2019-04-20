event_user(state_);
sprite_index = sprite_[state_, direction_facing_];
depth = -y;

if (o_game.save_data_[? o_game.PLAYER_HEALTH] <= 0 && !invincible_) {
	instance_destroy();
}