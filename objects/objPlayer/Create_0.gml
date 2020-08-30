up = false;
down = false;
left = false;
right = false;

function getSpd() {
  //If the player is STANDING on a slow-walking tile...
  if (state.get_current() != "jumping" && scr_player_foot_check(objSlowWalk)) {
    maxspd = 0.5;
    //Assign the slow walking speed.
  } else {
    maxspd = 1;
    //Assign standard walking speed.
  }
}

function isMoving() {
  return (
    (down && !global.sideview) || (up && !global.sideview) || left || right
  );
}

function getDir() {
  if (gamepad_is_connected(0)) {
    gamepad_set_axis_deadzone(0, 0.5);
    up =
      gamepad_axis_value(0, gp_axislv) < 0 || gamepad_button_check(0, gp_padu);
    down =
      gamepad_axis_value(0, gp_axislv) > 0 || gamepad_button_check(0, gp_padd);
    left =
      gamepad_axis_value(0, gp_axislh) < 0 || gamepad_button_check(0, gp_padl);
    right =
      gamepad_axis_value(0, gp_axislh) > 0 || gamepad_button_check(0, gp_padr);

    if (up && down) {
      up = false;
      down = false;
    }
    if (left && right) {
      left = false;
      right = false;
    }
  } else {
    down = keyboard_check(vk_down) && !keyboard_check(vk_up);
    up = keyboard_check(vk_up) && !keyboard_check(vk_down);
    left = keyboard_check(vk_left) && !keyboard_check(vk_right);
    right = keyboard_check(vk_right) && !keyboard_check(vk_left);
  }

  // Set sprite facing direction
  if (
    down &&
    ((!left && !right) ||
      (left && dir != Direction.LEFT) ||
      (right && dir != Direction.RIGHT))
  ) {
    dir = Direction.DOWN;
  }
  if (
    up &&
    ((!left && !right) ||
      (left && dir != Direction.LEFT) ||
      (right && dir != Direction.RIGHT))
  ) {
    dir = Direction.UP;
  }
  if (
    left &&
    ((!down && !up) ||
      (down && dir != Direction.DOWN) ||
      (up && dir != Direction.UP))
  ) {
    dir = Direction.LEFT;
  }
  if (
    right &&
    ((!down && !up) ||
      (down && dir != Direction.DOWN) ||
      (up && dir != Direction.UP))
  ) {
    dir = Direction.RIGHT;
  }
}

function isRolling(_dir) {
  if (doublekeytapdir != _dir) {
    //Make the double tap directional check for the given direction.
    doublekeytapdir = _dir;
    //Give the player twenty frames to tap it again.
    doublekeytapdly = global.onesecond / 3;
  } else if (doublekeytapdly && dir == doublekeytapdir) {
    // Otherwise, if it's pressed again within the checking interval,
    // and the player is facing in the right direction, prepare the player for
    // some rolling action.
    return true;
  }
}

//Flag the player as visible.
visible = true;

moveable = true; //Is the player ABLE to move?
spd = 0.5; //How fast, in pixels, does the player increase their movement speed?
maxspd = 1; //Maximum amount of speed the player can achieve.
//Which direction is the player facing?  D=Down, U=Up, L=Left, R=Right.
dir = Direction.DOWN;
/*
Which direction has the player pressed?  This will be used for
double tapping a directional key.
*/
doublekeytapdir = noone;
doublekeytapdly = 0; //Frames left before double tapping interval ends.
xoff = 0; //The x offset of which to draw the player's sprite.
yoff = 0; //The y offset of which to draw the player's sprite.
z = 0; //How high off of the ground, in pixels, the player is.
zmax = 0; //How high off of the ground, in pixels, the player needs to reach.
zspd = 0; //How fast is the player rising/falling, in pixels?
pushing = false; //Is the player pushing?
//How long, in frames, has the player been pushing?
pushtmr = 0;
slashing = false; //Is the player slashing?
charge = 0; //How long, in frames, has the player been charging.
tap = false; //Is the player tapping their sword against something?
tapreverse = false; //Is the player recovering from tapping the sword?
tapdly = 0; //How long, in frames, the player has to wait before tapping again.
spin = 0; //How many spin attacks has the player done.
smokedly = 0; //Delay before another smoke object is made.
cliff = false; //Is the player jumping down a cliff or not?
cliffdir = noone; //Which direction is the player jumping in?
cliffspd = 1; //How fast the player is moving for the cliff jump.
hvel = 0; //Conserve horizontal velocity when against a solid.
vvel = 0; //Conserve vertical velocity when against a solid.
myfriction = 0.25; //Amount of friction used to slow movement to a halt.
lhspeed = 0; //Conserve horizontal speed when the game is paused.
lvspeed = 0; //Conserve vertical speed when the game is paused.
gravity_direction = 270; //Gravity should point down in sideview areas.
mygravity = 0.5; //How much gravity the player has.
carrying = false; // Is the player holding something
heldObject = noone;
shielding = false; // Maybe this could be consolidated idk
shieldSprite = noone;
canMerge = false;
alarm[1] = global.onesecond;
pushdir = noone; // Just like it says

shader = shader_get_uniform(sh_saturation, "Degree"); // control shader
active = true;

party = 15;
partySize = 4;
inactiveSprite = -1;

ground_dx = 0;
ground_dy = 0;
pit_timer = get_timer();

global.playerid = id;

state = new StateMachine(
  "idle",
  "idle",
  {
    enter: function() {
      sprite_index = 0;
      image_speed = 0;
      scr_player_friction(true);
      scr_player_collide();

      pushtmr = 0;
      hspeed = 0;
      vspeed = 0;
    },
    step: function() {
      if (doublekeytapdly) {
        doublekeytapdly -= 1;
        if (doublekeytapdly <= 0) {
          doublekeytapdir = noone;
        }
      }
      if (isMoving()) {
        state_switch("walking");
        return;
      }
    }
  },
  "walking",
  {
    enter: function() {
      image_speed = 1;
      pushtmr = 0;
      if (isRolling(dir)) {
        state_switch("rolling");
        return;
      }
    },
    step: function() {
      if (!isMoving()) {
        state_switch("idle");
        return;
      }
      scr_player_friction(false);
      scr_player_collide();
      if (doublekeytapdly) {
        doublekeytapdly -= 1;
        if (doublekeytapdly <= 0) {
          doublekeytapdir = noone;
        }
      }

      //Restore any conserved movement force, if possible.
      if (vvel != 0) {
        if (
          (vvel > 0 && place_free(x, y + 1)) ||
          (vvel < 0 && place_free(x, y - 1))
        ) {
          vspeed = vvel;
          vvel = 0;
          scr_player_collide();
        }
      }
      if (hvel != 0) {
        if (
          (hvel > 0 && place_free(x + 1, y)) ||
          (hvel < 0 && place_free(x - 1, y))
        ) {
          hspeed = hvel;
          hvel = 0;
          scr_player_collide();
        }
      }
      getSpd();

      // Oh God this is so hacky
      scr_apply_movement(
        (down ? Direction.DOWN : 0) +
          (left ? Direction.LEFT : 0) +
          (right ? Direction.RIGHT : 0) +
          (up ? Direction.UP : 0),
        false,
        slashing
      );
    }
  },
  "rolling",
  {
    enter: function() {
      getSpd();
      myfriction = 0.05;
      audio_play_sound(sndRoll, 10, false);
    },
    step: function() {
      if (dir == Direction.DOWN) {
        vspeed = maxspd * 2.5;
      } else if (dir == Direction.UP) {
        vspeed = -maxspd * 2.5;
      } else if (dir == Direction.LEFT) {
        hspeed = -maxspd * 2.5;
      } else if (dir == Direction.RIGHT) {
        hspeed = maxspd * 2.5;
      }
      scr_player_collide();
      image_index = 0;
      scr_player_sprite_change();
      if (state.get_time() >= global.onesecond / 3) {
        state_switch("idle");
        return;
      }

      // Smoke drawing section!
      if (smokedly) {
        smokedly -= 1;
        //Subtract a frame from the delay.
      } else {
        //Otherwise, make a new smoke object here.
        s = instance_create_layer(x, y, "Player", objRollSmoke);

        // If the player is facing down, the smoke should appear behind
        //them.  Otherwise, it should be above them.
        if (dir == Direction.DOWN) {
          s.depth = depth + 2;
        } else {
          s.depth = depth - 2;
        }
        smokedly = 8;
        //Set the delay to 8 frames away.
      }

      scr_player_friction(true);
      scr_player_collide();
    },
    leave: function() {
      doublekeytapdir = noone;
      // Reset the interval for double key tapping.
      doublekeytapdly = 0;
      // And reset the pushing frame counter.
      pushtmr = 0;
      // Reset their animation frame.
      myfriction = 0.25;
    }
  },
  "jumping",
  {
    enter: function() {
      zpeak = false;
    },
    step: function() {
      // If the the player hasn't peaked yet, the zspd should be smaller the
      // closer  get to their peak.  Otherwise it should be larger as
      // approach the ground.
      zspd = max(abs(floor((zmax - z) / 8)), 1);
      if (!zpeak) {
        if (z - zspd >= zmax) {
          z -= zspd;
        } else {
          z = zmax;
          zpeak = true;
        }
      } else {
        if (z + zspd <= 0) {
          z += zspd;
        } else {
          z = 0;
          zpeak = false;
          zmax = 0;
          cliff = false;

          audio_play_sound(sndLand, 10, false);
          var _m = isMoving();
          state_switch(_m ? "walking" : "idle", _m ? false : true);
          return;
        }
      }
      scr_apply_movement(
        (down ? Direction.DOWN : 0) +
          (left ? Direction.LEFT : 0) +
          (right ? Direction.RIGHT : 0) +
          (up ? Direction.UP : 0),
        true,
        slashing
      );
    },
    leave: function() {
      zpeak = false;
    }
  },
  "pushing",
  {
    enter: function() {
      pushdir = dir;
    },
    step: function() {
      if (pushdir != dir) {
        state_switch("idle");
        return;
      }
      if (!up && !down && !left && !right) {
        state_switch("idle");
        return;
      }
      if (pushtmr >= global.onesecond / 4) {
        //Temporary variable for a possible cliff ahead of the player.
        var cliffobj = scr_ahead_check(objCliff, 1);

        if (cliffobj != -1 && !cliff && dir == cliffobj.dir) {
          hspeed = 0;
          vspeed = 0;
          //Have the player leave the ground a full tile.
          zmax = -16;
          state_switch("cliff");

          cliffdir = cliffobj.dir;
          audio_play_sound(sndCliff, 10, false);
          image_index = 0;
          scr_player_sprite_change();
          if (cliffdir == Direction.DOWN) {
            y += 2;
          } else if (cliffdir == Direction.UP) {
            y -= 2;
          } else if (cliffdir == Direction.LEFT) {
            x -= 2;
          } else {
            x += 2;
          }
        }
      }

      // If the player hasn't been pushing for a half second, add this
      // frame to the timer.  Otherwise, check for other things.
      if (pushtmr < global.onesecond / 2) {
        pushtmr += 1;
      } else {
        var pushobjchk = scr_ahead_check(objPushable, 1);
        if (pushobjchk != -1) {
          // If the object can still be pushed, and the player is trying
          // to push the object in the right direction, if
          // applicable...
          if (
            pushobjchk.pushes != 0 &&
            pushobjchk.pushx == 0 &&
            pushobjchk.pushy == 0 &&
            (pushobjchk.pushdir == noone ||
              array_contains(pushobjchk.pushdir, dir))
          ) {
            // Then push it!
            if (dir == Direction.DOWN) {
              if (
                place_free(pushobjchk.x, pushobjchk.y + 16) &&
                pushobjchk.y + 16 < room_height
              ) {
                pushobjchk.pushy = 16;
                audio_play_sound(sndPush, 10, false);
              }
            } else if (dir == Direction.UP) {
              if (
                place_free(pushobjchk.x, pushobjchk.y - 16) &&
                pushobjchk.y - 16 >= 0
              ) {
                pushobjchk.pushy = -16;
                audio_play_sound(sndPush, 10, false);
              }
            } else if (dir == Direction.LEFT) {
              if (
                place_free(pushobjchk.x - 16, pushobjchk.y) &&
                pushobjchk.x - 16 >= 0
              ) {
                pushobjchk.pushx = -16;
                audio_play_sound(sndPush, 10, false);
              }
            } else {
              if (
                place_free(pushobjchk.x + 16, pushobjchk.y) &&
                pushobjchk.x + 16 < room_width
              ) {
                pushobjchk.pushx = 16;
                audio_play_sound(sndPush, 10, false);
              }
            }
          }
        }
      }
      scr_apply_movement(
        (down ? Direction.DOWN : 0) +
          (left ? Direction.LEFT : 0) +
          (right ? Direction.RIGHT : 0) +
          (up ? Direction.UP : 0),
        false,
        slashing
      );
    }
  },
  "cliff",
  {
    enter: function() {},
    step: function() {
      if (!place_free(x, y)) {
        if (cliffdir == Direction.DOWN) {
          y += cliffspd;
        } else if (cliffdir == Direction.UP) {
          y -= cliffspd;
        } else if (cliffdir == Direction.LEFT) {
          x -= cliffspd;
        } else {
          x += cliffspd;
        }
      } else {
        cliffspd = 2;
        if (z + zspd <= 0) {
          z += zspd;
        } else {
          z = 0;
          zpeak = false;
          zmax = 0;
          cliff = false;

          audio_play_sound(sndLand, 10, false);
          state_switch("idle");
        }
      }
    }
  }
);
