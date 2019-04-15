/// @description Insert description here
// You can write your code in this editor
if (HurtboxEntityCanBeHitBy(other)) {
	invincible_ = true;
	alarm[0] = global.one_second * 0.75;
	var _health = ds_map_find_value(o_game.save_data_, o_game.PLAYER_HEALTH);
	_health--;
	ds_map_replace(o_game.save_data_, o_game.PLAYER_HEALTH, _health);
	var _direction = point_direction(other.x, other.y, x, y);
	SetMovement(_direction, other.knockback_);
	state_ = PlayerState.HIT;
	// Let's run this right away
	event_user(state_);
	audio_play_sound(a_hurt, 6, false);
	if (other.destroy_on_contact_) {
		instance_destroy(other);
	}
}