/*
This section of code checks for when the player steps outside of the screen.
As soon as  do, if there is a room in that direction, a scrolling
transition should happen.  Otherwise,  should be locked into the
screen, as if an invisible barrier were holding them in.
*/

//If the player steps off of the north boundary of the screen...
if (y < 0) {
  //If there is a room north of this one...
  if (global.northroom != -1) {
    //Set the next transition to the scrolling up transition.
    scr_room_transition(global.northroom, Transition.UP, 45);
    //Flag the player as invisible, so  won't show up on the surface.
    visible = false;
    //Flag the Control as invisible as well for the same reason.
    objControl.visible = false;
    //Flag the Weather as invisible as well for the same reason.
    objWeather.visible = false;
    //Flag any of the player's weapons as invisible as well.
    if (instance_exists(objWeapon)) {
      objWeapon.visible = false;
    }
    scr_reset_weather();
    //Reset the weather.
    //If the player is jumping down a cliff, reset their animation.
    if (cliff && image_index >= 3) {
      image_index = 0;
    }
    scr_align_camera(true);
    //Orient the screen just right.
    room_goto(global.northroom);
    //Go to the northern room.
    //Now place the player at the bottom of the room.
    y = room_height - sprite_height;
    //And get out of this code for this frame.
    exit;
  } else {
    //Otherwise, place the player back at the north edge of the screen.
    y = 0;
  }
}

//If the player steps off of the south boundary of the screen...
if (y + 16 > room_height) {
  //If there is a room south of this one...
  if (global.southroom != -1) {
    //Set the next transition to the scrolling down transition.
    scr_room_transition(global.southroom, Transition.DOWN, 45);
    //Flag the player as invisible, so  won't show up on the surface.
    visible = false;
    //Flag the Control as invisible as well for the same reason.
    objControl.visible = false;
    //Flag the Weather as invisible as well for the same reason.
    objWeather.visible = false;
    //Flag any of the player's weapons as invisible as well.
    if (instance_exists(objWeapon)) {
      objWeapon.visible = false;
    }
    if (cliff && image_index >= 3) {
      image_index = 0;
    }
    scr_align_camera(true);
    //Orient the screen just right.
    room_goto(global.southroom);
    //Go to the southern room.
    y = 0;
    //Place the player at the top of the room now.
    //And get out of this code for this frame.
    exit;
  } else {
    //Otherwise, place the player back at the south edge of the screen.
    y = room_height - 16;
  }
}

//If the player steps off of the west boundary of the screen...
if (x < 0) {
  //If there is a room west of this one...
  if (global.westroom != -1) {
    //Set the next transition to the scrolling left transition.
    scr_room_transition(global.westroom, Transition.LEFT, 45);
    //Flag the player as invisible, so  won't show up on the surface.
    visible = false;
    //Flag the Control as invisible as well for the same reason.
    objControl.visible = false;
    //Flag the Weather as invisible as well for the same reason.
    objWeather.visible = false;
    //Flag any of the player's weapons as invisible as well.
    if (instance_exists(objWeapon)) {
      objWeapon.visible = false;
    }
    scr_reset_weather();
    //Reset the weather.
    //If the player is jumping down a cliff, reset their animation.
    if (cliff && image_index >= 3) {
      image_index = 0;
    }
    scr_align_camera(true);
    //Orient the screen just right.
    room_goto(global.westroom);
    //Go to the western room.
    //Now place the player at the right of the room.
    x = room_width - sprite_width;
    //And get out of this code for this frame.
    exit;
  } else {
    //Otherwise, place the player back at the west edge of the screen.
    x = 0;
  }
}

//If the player steps off of the east boundary of the screen...
if (x + 16 > room_width) {
  //If there is a room east of this one...
  if (global.eastroom != -1) {
    //Set the next transition to the scrolling right transition.

    //Flag the player as invisible, so  won't show up on the surface.
    visible = false;
    //Flag the Control as invisible as well for the same reason.
    objControl.visible = false;
    //Flag the Weather as invisible as well for the same reason.
    objWeather.visible = false;
    //Flag any of the player's weapons as invisible as well.
    if (instance_exists(objWeapon)) {
      objWeapon.visible = false;
    }
    scr_reset_weather();
    //Reset the weather.
    //If the player is jumping down a cliff, reset their animation.
    if (cliff && image_index >= 3) {
      image_index = 0;
    }
    scr_align_camera(true);
    //Orient the screen just right.
    scr_room_transition(global.eastroom, Transition.RIGHT, 45);
    room_goto(global.eastroom);
    //Go to the eastern room.
    x = 0;
    //Place the player at the left of the room now.
    //And get out of this code for this frame.
    exit;
  } else {
    //Otherwise, place the player back at the east edge of the screen.
    x = room_width - 16;
  }
}
