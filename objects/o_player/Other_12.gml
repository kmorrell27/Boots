/// @description Evade State
// You can write your code in this editor

image_speed = 0.7;
SetMovement(roll_direction_, roll_speed_);
MoveMovementEntity(false);
if (AnimationHitFrame(image_number - 1)) {
	state_ = PlayerState.MOVE;
}