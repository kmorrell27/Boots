/// @description Hit State

MoveMovementEntity(true);
ApplyFrictionToMovementEntity();
if (speed_ == 0) {
	state_ = starting_state_;
}