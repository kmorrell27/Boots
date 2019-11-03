/*********************************************************************
This script is for the transition in which the screen closes a
rectangle around the player, and opens it up again in the new room.
The game automatically calls these transition scripts with the required
parameters as the transitions are called.  The fraction_of_transition
parameter is always between 0 and 1, inclusive, so with a little
algebra, you can use perfect screen transitions by multiplying with
this value.

format:  scr_tr_rectangle(surface_previous,surface_next,surface_width,surface_height,fraction_of_transition);
*********************************************************************/

//First we need a temporary surface to draw the rectangle.
var effectsurface = surface_create(argument2, argument3);

//Next a temporary variable for the alpha of the darkness.
var darknessalpha = 1;

/*
Temporary variables for the player's previous and current position,
relative to the previous and current view positions respectively.
*/
var lastplayerx = global.lastplayerx - global.lastviewx;
var lastplayery = global.lastplayery - global.lastviewy;
var ratio = display_get_gui_width() / camera_get_view_width(view_camera[0]);
var playerx = global.playerid.x - camera_get_view_x(view_camera[0]) * ratio;
var playery = global.playerid.y - camera_get_view_y(view_camera[0]) * ratio;

//Modify the alpha based on where the fraction is.
if (argument4 <= 0.25) {
  darknessalpha = argument4 / 0.25;
} else if (argument4 >= 0.75) {
  darknessalpha = 1 - (argument4 - 0.75) / 0.25;
}

//Start drawing on the temporary surface.
surface_set_target(effectsurface);
//Clear the entire surface with black.
draw_clear_alpha(c_black, darknessalpha);
//Change the blend mode so we can poke a hole in this black rectangle.
gpu_set_blendmode(bm_subtract);

/*
If we're in the first half of the transition, draw the rectangle closing
in on the player.  Otherwise, draw it opening out.  Drawing this rectangle
will be the hole cut into the surface.
*/
if (argument4 <= 0.5) {
  draw_rectangle_color(
    lastplayerx + 8 - ((0.5 - argument4) / 0.5) * 128,
    lastplayery + 8 - ((0.5 - argument4) / 0.5) * 128,
    lastplayerx + 8 + ((0.5 - argument4) / 0.5) * 128,
    lastplayery + 8 + ((0.5 - argument4) / 0.5) * 128,
    c_black,
    c_black,
    c_black,
    c_black,
    false
  );
} else {
  draw_rectangle_color(
    playerx + 8 - ((argument4 - 0.5) / 0.5) * 128,
    playery + 8 - ((argument4 - 0.5) / 0.5) * 128,
    playerx + 8 + ((argument4 - 0.5) / 0.5) * 128,
    playery + 8 + ((argument4 - 0.5) / 0.5) * 128,
    c_black,
    c_black,
    c_black,
    c_black,
    false
  );
}

//Reset the blend mode.
gpu_set_blendmode(bm_normal);
//Reset the drawing location.
surface_reset_target();

/*
For the first half of the transition, we want to use the image of the
last room.  Afterwards, we want to use the image of the next room.
*/

if (argument4 <= 0.5) {
  draw_surface_stretched(
    argument0,
    0,
    0,
    display_get_gui_width(),
    display_get_gui_height()
  );
  //Now draw the player's shadow and the player himself.
  if (instance_exists(objPlayer)) {
    draw_sprite_ext(
      sprShadow,
      -1,
      round(lastplayerx),
      round(lastplayery) + 1,
      global.playerid.image_xscale,
      global.playerid.image_yscale,
      global.playerid.image_angle,
      global.playerid.image_blend,
      global.playerid.image_alpha - 0.125
    );
    draw_sprite_ext(
      global.playerid.sprite_index,
      global.playerid.image_index,
      round(lastplayerx) + global.playerid.xoff,
      round(lastplayery) + global.playerid.yoff + global.playerid.z,
      global.playerid.image_xscale,
      global.playerid.image_yscale,
      global.playerid.image_angle,
      global.playerid.image_blend,
      global.playerid.image_alpha
    );
  }

  /*
    Then draw the HUD based on 0,0.  This isn't done based on the viewport
    because the viewport isn't used during transitions.
    */
  scr_draw_hud(0, 0);
  //Then draw the effect surface.
  draw_surface_stretched(
    effectsurface,
    0,
    0,
    display_get_gui_width(),
    display_get_gui_height()
  );
} else {
  draw_surface_stretched(
    argument1,
    0,
    0,
    display_get_gui_width(),
    display_get_gui_height()
  );
  //Now draw the player's shadow and the player himself.
  if (instance_exists(objPlayer)) {
    draw_sprite_ext(
      sprShadow,
      -1,
      round(playerx),
      round(playery) + 1,
      global.playerid.image_xscale,
      global.playerid.image_yscale,
      global.playerid.image_angle,
      global.playerid.image_blend,
      global.playerid.image_alpha - 0.125
    );
    draw_sprite_ext(
      global.playerid.sprite_index,
      global.playerid.image_index,
      round(playerx) + global.playerid.xoff,
      round(playery) + global.playerid.yoff + global.playerid.z,
      global.playerid.image_xscale,
      global.playerid.image_yscale,
      global.playerid.image_angle,
      global.playerid.image_blend,
      global.playerid.image_alpha
    );
  }

  //Now draw any weather effects, based on 0,0.
  with (objWeather) {
    scr_draw_weather();
  }

  /*
    Then draw the HUD based on 0,0.  This isn't done based on the viewport
    because the viewport isn't used during transitions.
    */
  scr_draw_hud(0, 0);
  //Then draw the effect surface.
  draw_surface_stretched(
    effectsurface,
    0,
    0,
    display_get_gui_width(),
    display_get_gui_height()
  );
}

//Now free up the memory from that temporary surface.
surface_free(effectsurface);
