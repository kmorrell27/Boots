/// @description Insert description here
// You can write your code in this editor
if (health_ <= 0) {
	exit;
}
if HurtboxEntityCanBeHitBy(other) {
	invincible_ = true;
	alarm[0] = global.one_second / 2;
	health_ -= other.damage_; // I still hate other, but this is better than with
	state_ = EnemyState.HIT;
		CreateAnimationEffect(s_hit_effect, x, y - 8, 1, true);
	SetMovement(point_direction(other.x, other.y, x, y), other.knockback_);
	audio_play_sound(a_hit, 7, false);
}