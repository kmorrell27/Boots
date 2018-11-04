///@arg hitbox
var _hitbox = argument0;
var _is_target = IsTarget(object_index, _hitbox.targets_);

return !invincible_ && _is_target;