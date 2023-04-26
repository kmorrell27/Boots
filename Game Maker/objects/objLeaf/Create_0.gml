image_speed = 0; //Do not animate.
horspd = 0; //The horizontal speed this will need to achieve.
verspd = 0; //The vertical speed this will need to achieve.
//Has this object reached the needed horizontal speed?
horachieved = false;
//Has this object reached the needed vertical speed?
verachieved = false;
lvspeed = 0; //Conserved vertical speed when the game is paused.
lhspeed = 0; //Conserved horizontal speed when the game is paused.
lifetmr = global.onesecond / 3; //How long, in frames, this has before it starts fading.
