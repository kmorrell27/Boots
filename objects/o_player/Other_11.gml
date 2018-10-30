/// @description Attack state
// You can write your code in this editor

image_speed = 0.8;

if (AnimationHitFrame(image_number - 1)) {
	state_ = PlayerState.MOVE;
}