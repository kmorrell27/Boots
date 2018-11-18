/// @description Insert description here
// You can write your code in this editor
if (HurtboxEntityCanBeHitBy(other)) {
	invincible_ = true;
	alarm[0] = global.one_second * 0.75;
	global.player_health -= other.damage_;
	var _direction = point_direction(other.x, other.y, x, y);
	SetMovement(_direction, other.knockback_);
	state_ = PlayerState.HIT;
	// Let's run this right away
	event_user(state_);
	audio_play_sound(a_hurt, 6, false);
}