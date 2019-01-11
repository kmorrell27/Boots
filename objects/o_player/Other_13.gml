/// @description Attack state
// You can write your code in this editor

// This should be programmatic
instance_create_layer(x, y, "Instances", o_bomb);
audio_play_sound(a_set_bomb, 5, false);
state_ = PlayerState.MOVE;