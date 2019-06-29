//Draw the HUD based on the viewport.
scr_draw_hud(0,0);

//If the area name has frames left of being drawn...
if (global.showarea > 0) {
  //A little boolean arithmetic to get the text to scroll in.
  var textxpos =
    80 +
    round(160 * ((global.showarea - 90) / 30) * (global.showarea > 90)) -
    round(160 * ((30 - global.showarea) / 30) * (global.showarea <= 30));
  //More boolean arithmetic to get the text to fade in and out too.
  var textalpha =
    1 -
    1 * ((global.showarea - 90) / 30) * (global.showarea > 90) -
    1 * ((30 - global.showarea) / 30) * (global.showarea <= 30);

  //Use the non-monospaced font we made.
  draw_set_font(global.tightfont);
  //Set the drawing alignment to be centered.
  draw_set_halign(fa_center);
  //Now draw the area name based on the center of the screen.
  scr_outline_text(
    camera_get_view_x(view_camera[0]) + textxpos,
    camera_get_view_y(view_camera[0]) + 72,
    global.areaname,
    CL_WHITE,
    CL_BLACK,
    textalpha
  );
  //Reset the drawing alignment to the left.
  draw_set_halign(fa_left);
  draw_set_font(global.font); //Use the regular font now.
}

//If the menu is anchored somewhere, draw it.
if (global.menuanchor != 0) {
  scr_draw_menu(camera_get_view_x(view_camera[0]), camera_get_view_y(view_camera[0]), 1);
}
