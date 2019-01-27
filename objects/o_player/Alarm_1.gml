///@desc Stamina refill
var _stamina = ds_map_find_value(o_game.save_data_, o_game.PLAYER_STAMINA);
var _max_stamina = ds_map_find_value(o_game.save_data_, o_game.PLAYER_MAX_STAMINA);
_stamina = min(_stamina + 1, _max_stamina);
ds_map_replace(o_game.save_data_, o_game.PLAYER_STAMINA, _stamina);
if (_stamina < _max_stamina) {
	alarm[1] = global.one_second;
}