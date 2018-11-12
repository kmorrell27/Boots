/// @description Move State
image_speed = 0.35;
var _x_speed = lengthdir_x(speed_, direction_);
if (_x_speed != 0) {
	image_xscale = sign(_x_speed);
	
}

if (alarm[1] <= 0) {
	ApplyFrictionToMovementEntity();
} else {
	AddMovementMaxSpeed(direction_, 0.05, 0.5);
	MoveMovementEntity(true);
}

if (speed_ == 0) {
	alarm[1] = random_range(1, 3) * global.one_second;
	state_ = PorcupineState.IDLE;
}

PorcupineAttack();