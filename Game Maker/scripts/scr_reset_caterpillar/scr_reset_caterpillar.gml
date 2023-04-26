// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_reset_caterpillar() {
  for (var i = 95; i >= 0; i--) {
    xPos[i] = x;
    yPos[i] = y;
    zPos[i] = z;
    dirHistory[i] = dir;
  }
}
