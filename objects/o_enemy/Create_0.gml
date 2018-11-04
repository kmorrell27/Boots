InitializeMovementEntity(1, 0.5, o_solid);
InitializeHurtboxEntity();

max_health_ = 2;
health_ = max_health_;
starting_state_ = noone; // Hmmmmmm
state_ = starting_state_;
image_speed = 0;

enum EnemyState {
	HIT
}