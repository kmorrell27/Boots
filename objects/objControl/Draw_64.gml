/// @description Insert description here
// You can write your code in this editor
scr_draw_hud(0, 0);

//If the area name has frames left of being drawn...
if (global.showarea > 0) {
  //A little boolean arithmetic to get the text to scroll in.
  var textxpos = 128 +
  round(
    256 *
    ((global.showarea - global.onesecond * 3) / global.onesecond) *
    (global.showarea > global.onesecond * 3)
  ) -
  round(
    256 *
    ((global.onesecond - global.showarea) / global.onesecond) *
    (global.showarea <= global.onesecond)
  );
  //More boolean arithmetic to get the text to fade in and out too.
  var textalpha = 1 -
  1 *
  ((global.showarea - global.onesecond * 3) / global.onesecond) *
  (global.showarea > global.onesecond * 3) -
  1 *
  ((global.onesecond - global.showarea) / global.onesecond) *
  (global.showarea <= global.onesecond);
  
  //Use the non-monospaced font we made.
  draw_set_font(global.tightfont);
  //Set the drawing alignment to be centered.
  draw_set_halign(fa_center);
  //Now draw the area name based on the center of the screen.
  scr_outline_text(
    textxpos,
    72,
    global.areaname,
    CL_WHITE,
    CL_BLACK,
    textalpha
  );
  //Reset the drawing alignment to the left.
  draw_set_halign(fa_left);
  draw_set_font(global.font);
  //Use the regular font now.
}

//If the menu is anchored somewhere, draw it.
if (global.menuanchor != 0) {
  scr_draw_menu(0, 0, 1);
}
