///@arg file_name
var _file_name = argument0;

ini_open(_file_name);
var _room = ini_read_string("Level", "Room", "");
if (_room == "") {
	show_error("Invalid save data", false);
}


var _x = ini_read_real("Level", "Start x", 0);
var _y = ini_read_real("Level", "Start y", 0);
var _room_index = asset_get_index(_room);
global.player_start_position = room_instance_add(_room_index, _x, _y, o_start_position);
room_goto(_room_index);

ini_close();