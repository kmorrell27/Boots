/// @description Attack state
SetSpriteFacing();

if (!instance_exists(o_player) || distance_to_object(o_player > range_)) {
	state_ = BatState.MOVE;
	
	if (!instance_exists(o_player)) {
		exit;
	}
}

var _direction = point_direction(x, y, o_player.x, o_player.y);
AddMovementMaxSpeed(_direction, 0.123, 1);
MoveMovementEntity(true);
// This checks if the player is at x y
var _player = instance_place(x, y, o_player);
if (_player) {
	CreateHitbox(sprite_index, x, y, 0, 1, [o_player], 1, 5);
}