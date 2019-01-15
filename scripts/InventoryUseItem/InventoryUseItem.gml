///@arg input
///@arg action
var _input = argument0;
var _item = argument1;
if (_input) {
	if (instance_exists(_item) && global.player_stamina >= _item.cost_) {
		state_ = _item.action_;
		global.player_stamina -= _item.cost_;
		o_player.alarm[1] = global.one_second;
		image_index = 0;
	}
}