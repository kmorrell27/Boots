/// @description Attack state
// You can write your code in this editor

image_speed = 0.8;

// This should be programmatic
if (AnimationHitFrame(1)) {
	var _hitbox = CreateHitbox(s_sword_hitbox, x, y, direction_facing_ * 90, 3, [o_enemy, o_grass, o_bush], 1, 8);
	audio_play_sound(a_swipe, 8, false);
	switch (direction_facing_) {
		case Direction.UP:
			_hitbox.y -= 4;
			break;
		case Direction.DOWN:
			_hitbox.y += 4;
			break;
		case Direction.LEFT:
			_hitbox.x -= 4;
			break;
		case Direction.RIGHT:
			_hitbox.x +=4;
			break;
	}
}
if (AnimationHitFrame(image_number - 1)) {
	state_ = PlayerState.MOVE;
}