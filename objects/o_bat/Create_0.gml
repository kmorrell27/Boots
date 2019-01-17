event_inherited();
InitializeMovementEntity(0.25, 0.5, o_solid);

enum BatState {
	HIT,
	MOVE,
	ATTACK
}

starting_state_ = BatState.MOVE;
state_ = starting_state_;
alarm[1] = global.one_second * random_range(0, 1);
range_ = 64;
image_index = 0;
image_xscale = choose(1, -1);
image_speed = 0.5;