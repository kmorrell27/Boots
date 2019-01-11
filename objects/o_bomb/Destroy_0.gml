var _explosion = CreateAnimationEffect(s_explosion_effect, x, y, 1, true);
CreateHitbox(s_bomb_hitbox, x, y - 4, 0, 3, [o_enemy, o_grass, o_player], 2, 12);
audio_play_sound(a_explosion, 7, false);