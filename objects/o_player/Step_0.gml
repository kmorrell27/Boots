event_user(state_);
sprite_index = sprite_[state_, facing_];
depth = -y;

if (global.player_health <= 0 && !invincible_) {
	instance_destroy();
}