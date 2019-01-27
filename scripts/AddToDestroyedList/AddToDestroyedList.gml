///@arg instance_id
var _id = argument0;
ds_map_replace(ds_map_find_value(o_game.save_data_, "destroyed"), _id, true);