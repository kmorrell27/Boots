function scr_set_area_name(argument0) {
  /*
	If the player isn't already considered in this area, then we need to show
	the new area name on the screen, in 120 frames.
	*/
  if (global.areaname != argument0) {
    global.showarea = global.onesecond * 4;
  }

  global.areaname = argument0; //Set the new area name.
}
