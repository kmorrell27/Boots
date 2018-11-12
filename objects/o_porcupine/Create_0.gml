/// @description Insert description here
// You can write your code in this editor
event_inherited();
InitializeMovementEntity(0.5, 0.5, o_solid);
enum PorcupineState {
	HIT,
	IDLE,
	MOVE,
	ATTACK,
	WAIT
}

starting_state_ = PorcupineState.IDLE;
state_ = starting_state_;

image_index = 0;
image_xscale = choose(-1, 1);

alarm[1] = random_range(0, 1) * global.one_second;