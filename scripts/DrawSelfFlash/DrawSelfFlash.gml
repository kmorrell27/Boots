///@arg color
///@arg interval
///@arg alarm

var _color = argument0;
var _interval = argument1;
var _alarm = argument2;

if ((_alarm % _interval <= _interval / 2) && _alarm > 0) {
	gpu_set_fog(true, _color, 0, 1);
	draw_self();
	gpu_set_fog(false, _color, 0, 1);
}