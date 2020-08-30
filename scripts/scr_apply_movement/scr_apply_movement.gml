function scr_apply_movement(_dir, is_jumping, is_sword_out) {
  // Let's assume we're gonna leave this walking or jumping
  state_switch(is_jumping ? "jumping" : "walking", false);
  var up = (_dir & Direction.UP) > 0;
  var down = (_dir & Direction.DOWN) > 0;
  var left = (_dir & Direction.LEFT) > 0;
  var right = (_dir & Direction.RIGHT) > 0;

  if (down && !global.sideview) {
    if (place_free(x, y + 1)) {
      if (vvel == 0) {
        scr_add_vspeed(spd - (spd / 2) * is_jumping);
      } else {
        scr_add_vvel(spd - (spd / 2) * is_jumping);
      }
      scr_player_collide();
    } else if (
      place_free(x - 6, y + 1) &&
      !left &&
      !right &&
      dir == Direction.DOWN
    ) {
      if (hvel == 0) {
        scr_add_hspeed(-spd + (spd / 2) * is_jumping);
      } else {
        scr_add_hvel(-spd + (spd / 2) * is_jumping);
      }
      scr_player_collide();
    } else if (
      place_free(x + 6, y + 1) &&
      !left &&
      !right &&
      dir == Direction.DOWN
    ) {
      if (hvel == 0) {
        scr_add_hspeed(spd - (spd / 2) * is_jumping);
      } else {
        scr_add_hvel(spd - (spd / 2) * is_jumping);
      }
      scr_player_collide();
    } else {
      scr_player_collide();
      if (dir == Direction.DOWN && !is_jumping) {
        if (!is_sword_out) {
          state_switch("pushing");
        } else if (!tapdly) {
          tap = true;
        }
      }
    }
  }

  if (up && !global.sideview) {
    if (place_free(x, y - 1)) {
      if (vvel == 0) {
        scr_add_vspeed(-spd + (spd / 2) * is_jumping);
      } else {
        scr_add_vvel(-spd + (spd / 2) * is_jumping);
      }
      scr_player_collide();
    } else if (
      place_free(x - 6, y - 1) &&
      !left &&
      !right &&
      dir == Direction.UP
    ) {
      if (hvel == 0) {
        scr_add_hspeed(-spd + (spd / 2) * is_jumping);
      } else {
        scr_add_hvel(-spd + (spd / 2) * is_jumping);
      }
      scr_player_collide();
    } else if (
      place_free(x + 6, y - 1) &&
      !left &&
      !right &&
      dir == Direction.UP
    ) {
      if (hvel == 0) {
        scr_add_hspeed(spd - (spd / 2) * is_jumping);
      } else {
        scr_add_hvel(spd - (spd / 2) * is_jumping);
      }
      scr_player_collide();
    } else {
      scr_player_collide();
      if (dir == Direction.UP && !is_jumping) {
        if (!is_sword_out) {
          state_switch("pushing");
        } else if (!tapdly) {
          tap = true;
        }
      }
    }
  }

  if (left) {
    if (place_free(x - 1, y)) {
      if (hvel == 0) {
        scr_add_hspeed(-spd + (spd / 2) * is_jumping);
      } else {
        scr_add_hvel(-spd + (spd / 2) * is_jumping);
      }
      scr_player_collide();
    } else if (
      place_free(x - 1, y - 6) &&
      !global.sideview &&
      !down &&
      !up &&
      dir == Direction.LEFT
    ) {
      if (vvel == 0) {
        scr_add_vspeed(-spd + (spd / 2) * is_jumping);
      } else {
        scr_add_vvel(-spd + (spd / 2) * is_jumping);
      }
      scr_player_collide();
    } else if (
      place_free(x - 1, y + 6) &&
      !global.sideview &&
      !down &&
      !up &&
      dir == Direction.LEFT
    ) {
      if (vvel == 0) {
        scr_add_vspeed(spd - (spd / 2) * is_jumping);
      } else {
        scr_add_vvel(spd - (spd / 2) * is_jumping);
      }
      scr_player_collide();
    } else {
      scr_player_collide();
      if (dir == Direction.LEFT && !is_jumping) {
        if (!is_sword_out) {
          state_switch("pushing");
        } else if (!tapdly) {
          tap = true;
        }
      }
    }
  }

  if (right) {
    if (place_free(x + 1, y)) {
      if (hvel == 0) {
        scr_add_hspeed(spd - (spd / 2) * is_jumping);
      } else {
        scr_add_hvel(spd - (spd / 2) * is_jumping);
      }
      scr_player_collide();
    } else if (
      place_free(x + 1, y - 6) &&
      !global.sideview &&
      !down &&
      !up &&
      dir == Direction.RIGHT
    ) {
      if (vvel == 0) {
        scr_add_vspeed(-spd + (spd / 2) * is_jumping);
      } else {
        scr_add_vvel(-spd + (spd / 2) * is_jumping);
      }
      scr_player_collide();
    } else if (
      place_free(x + 1, y + 6) &&
      !global.sideview &&
      !down &&
      !up &&
      dir == Direction.RIGHT
    ) {
      if (vvel == 0) {
        scr_add_vspeed(spd - (spd / 2) * is_jumping);
      } else {
        scr_add_vvel(spd - (spd / 2) * is_jumping);
      }
      scr_player_collide();
    } else {
      scr_player_collide();
      if (dir == Direction.RIGHT && !is_jumping) {
        if (!is_sword_out) {
          state_switch("pushing");
        } else if (!tapdly) {
          tap = true;
        }
      }
    }
  }
}
