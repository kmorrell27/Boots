///@arg instance_id
var _id = argument0;
var _destroyed_map = ds_map_find_value(o_game.save_data_, "destroyed");
return ds_map_find_value(_destroyed_map, _id);