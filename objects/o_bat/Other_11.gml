///@desc Move state
SetSpriteFacing();
AddMovementMaxSpeed(direction_, 0.05, 0.5);
MoveMovementEntity(true);

if (alarm[1] <= 0) {
	alarm[1] = global.one_second * random_range(1, 3);
	direction_ = random(360);
}

if (instance_exists(o_player) && distance_to_object(o_player) <= range_) {
	state_ = BatState.ATTACK;
}