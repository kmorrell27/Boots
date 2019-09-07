zmax = -8; //How high, in pixels, does this need to go.
zmin = 0; //How low, in pixels, does this need to go.
z = 0; //How high off of the ground, in pixels, is this object?
zspd = 0; //How fast, in pixels is this object rising/falling?
zpeak = false; //Has the object peaked at the max z yet?
flying = false; //Is this a flying item?
//How long, in frames, must Link wait before he can get this?
getdly = global.onesecond / 3;
got = false; //Has Link picked this up yet?
//How long, in frames, before this item starts rotating to Link.
gotdly = global.onesecond / 2;
used = false; //Has Link used this item yet?
//How long, in frames, before this item starts disappearing?
fadedly = global.onesecond * 10;
nofade = false; //Is this item NOT going to fade away?
image_speed = 0.25; //How fast this animates.
//The horizontal momentum this object has up against a wall.
hforce = 0;
//The vertical momentum this object has up against a wall.
vforce = 0;
friction = 0.25; //How much this object slows down each frame.
lastvspeed = 0; //Conserved vertical motion when the game is paused.
lasthspeed = 0; //Conserved horizontal motion when the game is paused.
/*
Conserved animation speed when the game is paused.  Negative is
no conservation.
*/
lastanispd = -1;

/* */
/*  */
