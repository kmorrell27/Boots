/// @description Move state

image_speed = 0;
var _animation_speed = 0.6;
var _x_input = keyboard_check(vk_right) - keyboard_check(vk_left);
var _y_input = keyboard_check(vk_down) - keyboard_check(vk_up);
var _attack_input = keyboard_check_pressed(ord("X"));
var _roll_input = keyboard_check_pressed(ord("Z"));
var _input_direction = point_direction(0, 0, _x_input, _y_input);

if (_x_input == 0 && _y_input == 0) {
	image_index = 0;
	image_speed = 0;
	ApplyFrictionToMovementEntity();
} else {
	image_speed = _animation_speed;
	// This still feels hacky
	image_xscale = _x_input > 0 ? 1 : -1;
	facing = GetDirectionFacing(_input_direction);
	roll_direction_ = facing * 90;
	AddMovementMaxSpeed(_input_direction, acceleration_, max_speed_);
}

if (_attack_input) {
	image_index = 0;
	state_ = PlayerState.SWORD;
} else if (_roll_input) {
	image_index = 0;
	state_ = PlayerState.EVADE;
}

MoveMovementEntity(false);