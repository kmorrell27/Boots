/// @description Attack state
image_speed = 0.25;

if (AnimationHitFrame(1)) {
	CreateHitbox(s_porcupine_hitbox, x, y - 8, 0, 1, [o_player], 1, 4);
	audio_play_sound(a_porcupine_attack, 5, false);
}

if (AnimationHitFrame(image_number - 1)) {
	state_ = PorcupineState.IDLE;
	sprite_index = s_porcupine_run;
	alarm[1] = 2 * global.one_second;
}