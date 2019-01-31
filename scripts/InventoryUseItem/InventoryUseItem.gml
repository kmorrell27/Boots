///@arg input
///@arg action
var _input = argument0;
var _item = argument1;
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
	var _stamina = ds_map_find_value(o_game.save_data_, o_game.PLAYER_STAMINA);
	if (instance_exists(_item) && _stamina >= _item.cost_) {
		state_ = _item.action_;
		_stamina -= _item.cost_;
		ds_map_replace(o_game.save_data_, o_game.PLAYER_STAMINA, _stamina);
		o_player.alarm[1] = global.one_second;
		image_index = 0;
	}
}