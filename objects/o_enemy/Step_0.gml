depth = -y;

if (health_ <= 0 && state_ != EnemyState.HIT) {
	instance_destroy();
}

if (state_ != noone) {
	event_user(state_);
}