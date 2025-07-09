event_inherited(); //Call the parent event.
dir = noone; //Which direction is the arrow traveling in?
image_speed = 0; //No animation speed.
spd = 8; //How far, in pixels, the arrow travels per frame.
alarm[0] = 2 * global.onesecond;
alarm[1] = 3 * global.onesecond;
durable = true;
doesdamage = false;
