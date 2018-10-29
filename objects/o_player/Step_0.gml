image_speed = 0;
var _animation_speed = 0.6;
var _x_input = keyboard_check(vk_right) - keyboard_check(vk_left);
var _y_input = keyboard_check(vk_down) - keyboard_check(vk_up);
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
	AddMovementMaxSpeed(_input_direction, acceleration_, max_speed_);
}

sprite_index = sprite_[Player.MOVE, facing];
MoveMovementEntity(false);