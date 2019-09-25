/********************************************************************
This script draws the current weather on the screen.

format:  scr_draw_weather(xpos,ypos);
********************************************************************/

//If it's raining, do what's in here.
if (global.rain && !global.inside) {
  //Change the drawing transparency to slightly above half.
  draw_set_alpha(image_alpha - 0.375);
  //Now draw a dim rectangle over the screen.
  draw_rectangle_color(
    0,
    0,
    display_get_gui_width(),
    display_get_gui_height(),
    Color.BLACK,
    Color.BLACK,
    Color.BLACK,
    Color.BLACK,
    false
  );
  //Reset the drawing transparency.
  draw_set_alpha(1);
  //Now draw the actual rain.
  draw_sprite_ext(
    sprRain,
    -1,
    0,
    0,
    image_xscale,
    image_yscale,
    image_angle,
    image_blend,
    image_alpha - 0.375
  );
  draw_sprite_ext(
    sprRain,
    -1,
    160,
    0,
    image_xscale,
    image_yscale,
    image_angle,
    image_blend,
    image_alpha - 0.375
  );

  //If it's thundering, go in here.
  if (thunder) {
    //Change the drawing transparency to what the lightning needs.
    draw_set_alpha(thunderalpha);
    //Now draw a white rectangle over the screen.
    draw_rectangle_color(
      0,
      0,
      display_get_gui_width(),
      display_get_gui_height(),
      Color.WHITE,
      Color.WHITE,
      Color.WHITE,
      Color.WHITE,
      false
    );
    //Reset the drawing transparency.
    draw_set_alpha(1);
  }
}
