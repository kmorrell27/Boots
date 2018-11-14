/// @description Hit state
image_index = 0;
MoveMovementEntity(true);
ApplyFrictionToMovementEntity();

if (speed_ == 0) {
	state_ = PlayerState.MOVE;
}