draw_sprite(s_shadow_medium, 0, x, y);
draw_self();
if (sprite_exists(found_item_sprite_)) {
	draw_sprite(found_item_sprite_, 0, x, y - 32);
}
DrawSelfFlash(c_white, 12, alarm[0]);