if (image_index != 270 && should_draw_shadow_) {
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_black, 0.4);
}
draw_sprite_ext(sprite_index, image_index, x, y - 7, image_xscale, image_yscale, image_angle, image_blend, image_alpha);