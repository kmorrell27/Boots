if keyboard_check_pressed(vk_escape) {
	paused_ = !paused_;
	if (paused_) {
		paused_sprite_ = sprite_create_from_surface(
			application_surface,
			0,
			0,
			view_wport[0],
			view_hport[0],
			false,
			false,
			0,
			0);
		instance_deactivate_all(true);	
		audio_play_sound(a_pause, 5, false);
	} else {
		if (sprite_exists(paused_sprite_)) {
			sprite_delete(paused_sprite_);
		}
		instance_activate_all();
		audio_play_sound(a_unpause, 5, false);
	}
}