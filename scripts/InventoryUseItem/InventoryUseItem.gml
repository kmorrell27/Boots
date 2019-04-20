///@arg input
///@arg action
///@arg action
var _input = argument0;
var _item = argument1;
var _action = argument2;
if (_input) {
	var _target_x = x + lengthdir_x(8, direction_facing_ * 90);
	var _target_y = y + lengthdir_y(8, direction_facing_ * 90);
	var _interactable = instance_place(_target_x, _target_y, o_interactable);
	if (_interactable && _interactable.activatable_) {
		with (_interactable) {
			event_user(InteractableState.ACTIVATE);
		}
		return;
	}
	if (instance_exists(_item)) {
		action_ = _action;
		state_ = _item.action_;
		sub_action_ = _item.sub_action_;
		image_index = 0;
	}
}