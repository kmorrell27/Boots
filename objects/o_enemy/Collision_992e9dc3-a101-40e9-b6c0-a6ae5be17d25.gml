/// @description Insert description here
// You can write your code in this editor
if (health_ <= 0) {
	exit;
}
if HurtboxEntityCanBeHitBy(other) {
	invincible_ = true;
	alarm[0] = game_get_speed(gamespeed_fps) / 4;
	health_ -= other.damage_; // I still hate other, but this is better than with
	state_ = EnemyState.HIT;
	SetMovement(point_direction(other.x, other.y, x, y), other.knockback_);
}