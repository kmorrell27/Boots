/// @description Move state

// This is super hacky dude
image_speed = 0;
if (instance_exists(sys_transition)) {
	return;
}

var _animation_speed = 0.6;
var _x_input = o_input.right_ - o_input.left_;
var _y_input = o_input.down_ - o_input.up_;
var _input_direction = point_direction(0, 0, _x_input, _y_input);

if (_x_input == 0 && _y_input == 0) {
	image_index = 0;
	image_speed = 0;
	ApplyFrictionToMovementEntity();
} else {
	image_speed = _animation_speed;
	// This still feels hacky
	image_xscale = _x_input > 0 ? 1 : -1;
	direction_facing_ = GetDirectionFacing(_input_direction);
	roll_direction_ = direction_facing_ * 90;
	AddMovementMaxSpeed(_input_direction, acceleration_, max_speed_);
}

var _items = o_game.save_data_[? o_game.ITEMS];
InventoryUseItem(o_input.action_one_pressed_, _items[0], PlayerAction.ONE);
InventoryUseItem(o_input.action_two_pressed_, _items[1], PlayerAction.TWO);

MoveMovementEntity(false);