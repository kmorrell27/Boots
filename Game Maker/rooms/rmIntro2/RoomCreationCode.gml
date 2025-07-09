/*
If it isn't raining, play the regular music here.  Otherwise,
use the rain music, since we need weathery music!
*/
if (!global.rain) {
  //scr_change_music(msKakariko);
} else {
  //scr_change_music(msRain);
}

//Set adjacent rooms (north, south, west, east).
scr_set_adjacent_rooms(-1, rmIntro1, -1, rmIntro3);

//Make sure sideview is altered for this room.
scr_set_sideview(false);
