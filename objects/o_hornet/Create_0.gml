event_inherited();

image_speed = 1;

enum HornetState {
	HIT,
	MOVE,
	ATTACK
}

starting_state_ = HornetState.MOVE;
state_ = starting_state_;

alarm[1] = global.one_second * random_range(0, 1);
alarm[2] = global.one_second * random_range(6, 8);

image_index = 0;
image_xscale = choose(-1, 1);
range_ = 120;