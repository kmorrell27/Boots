/// @description Found item state
if (alarm[2] <= 0 || o_input.action_one_pressed_ || o_input.action_two_pressed_) {
	state_ = PlayerState.MOVE;
	found_item_sprite_ = noone;
	invincible_ = false;
}