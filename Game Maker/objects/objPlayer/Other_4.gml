scr_align_camera(true); //Align the view instantly.
doublekeytapdir = noone; //Reset the double key tap check direction.
doublekeytapdly = 0; //Reset the interval for double key tapping.

global.playerLayer = layer_get_id("Player"); // I wonder how this ever worked
global.textLayer = layer_get_id("Text");

scr_reset_caterpillar();
