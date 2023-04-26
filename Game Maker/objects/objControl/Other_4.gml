/// @description Insert description here
// You can write your code in this editor
global.playerLayer = layer_get_id("Player");
if (instance_exists(objPlayer)) {
  global.lastplayerx = objPlayer.x;
  global.lastplayery = objPlayer.y;
}
