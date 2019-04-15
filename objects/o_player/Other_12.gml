/// @description Evade State
// You can write your code in this editor

image_speed = 0.7;

if (AnimationHitFrame(0)) {
	audio_play_sound(a_evade, 5, false);
}

SetMovement(roll_direction_, roll_speed_);
MoveMovementEntity(false);
if (AnimationHitFrame(image_number - 1)) {
	state_ = PlayerState.MOVE;
}