/// @description Move state

image_speed = 0;
var _animation_speed = 0.6;
var _x_input = o_input.right_ - o_input.left_;
var _y_input = o_input.down_ - o_input.up_;
var _attack_input = o_input.action_one_pressed_;
var _roll_input = o_input.action_two_pressed_;
var _input_direction = point_direction(0, 0, _x_input, _y_input);

if (_x_input == 0 && _y_input == 0) {
	image_index = 0;
	image_speed = 0;
	ApplyFrictionToMovementEntity();
} else {
	image_speed = _animation_speed;
	// This still feels hacky
	image_xscale = _x_input > 0 ? 1 : -1;
	facing_ = GetDirectionFacing(_input_direction);
	roll_direction_ = facing_ * 90;
	AddMovementMaxSpeed(_input_direction, acceleration_, max_speed_);
}

InventoryUseItem(o_input.action_one_pressed_, global.item[0]);
InventoryUseItem(o_input.action_two_pressed_, global.item[1]);

MoveMovementEntity(false);