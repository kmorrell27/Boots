/// @description Shoot state
speed_ = 0;

var _bow_speed = 0.5;
image_speed = _bow_speed;
if (AnimationHitFrame(3)) {
	if (sub_action_ = ShootAction.BOW) {
		image_speed = 0;
		var _released = false;
		if (action_ == PlayerAction.ONE) {
			_released = !o_input.action_one_held_;
		} else {
			_released = !o_input.action_two_held_;
		}
		if (_released) {
			sub_action_ = noone;
			audio_play_sound(a_swipe, 2, false);
			image_speed = _bow_speed;
			var _arrow = instance_create_layer(x, y, "Instances", o_arrow);
			_arrow.direction = direction_facing_ * 90;
			_arrow.image_angle = direction_facing_ * 90;
			_arrow.speed = 4;
	
			switch direction_facing_ {
				case Direction.RIGHT:
				case Direction.LEFT:
					_arrow.y -= 4;
					break;
				case Direction.UP:
					_arrow.y -= 2;
					break;
				default:
					break;
			}
		}
	}
	else if (sub_action_ = ShootAction.FIRE) {
		sub_action_ = noone;
		var _fire = instance_create_layer(x, y, "Instances", o_fire);
		_fire.direction = direction_facing_ * 90;
		_fire.speed = 4;
		switch direction_facing_ {
			case Direction.RIGHT:
			case Direction.LEFT:
				_fire.y -= 4;
				break;
			case Direction.UP:
				_fire.y -= 2;
				break;
			default:
				break;
		}
	}
}

if (AnimationHitFrame(image_number - 1)) {
	state_ = PlayerState.MOVE;
	image_index = 0;
}