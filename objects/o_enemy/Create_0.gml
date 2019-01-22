InitializeMovementEntity(1, 0.5, o_solid);
InitializeHurtboxEntity();

image_speed = 0;

max_health_ = 2;
health_ = max_health_;
starting_state_ = noone; // Hmmmmmm
state_ = starting_state_;

enum EnemyState {
	HIT
}