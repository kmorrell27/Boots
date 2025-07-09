function scr_set_adjacent_rooms(argument0, argument1, argument2, argument3) {
  /*********************************************************************
	This script sets which rooms are adjecent to this one, used for
	screen-scrolling.  You pass the room IDs as the parameters into this
	script, and they are stored into the global variables.  -1 is used
	to denote no room in that direction.

	format:  scr_set_adjacent_rooms(northroom,southroom,westroom,eastroom)
	*********************************************************************/

  global.northroom = argument0;
  global.southroom = argument1;
  global.westroom = argument2;
  global.eastroom = argument3;
}
