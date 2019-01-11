draw_sprite(s_shadow_medium, 0, x, y);
draw_self();
var _interval = ceil(alarm[0] / global.one_second) * 8;
DrawSelfFlash(c_red, _interval, alarm[0]);