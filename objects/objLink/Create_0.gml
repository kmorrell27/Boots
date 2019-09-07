moveable = true; //Is Link ABLE to move?
isMoving = false; //Is Link moving?
spd = 0.5; //How fast, in pixels, does Link increase his movement speed?
maxspd = 1; //Maximum amount of speed Link can achieve.
//Which direction is Link facing?  D=Down, U=Up, L=Left, R=Right.
dir = Direction.DOWN;
/*
Which direction has the player pressed?  This will be used for
double tapping a directional key.
*/
doublekeytapdir = noone;
doublekeytapdly = 0; //Frames left before double tapping interval ends.
xoff = 0; //The x offset of which to draw Link's sprite.
yoff = 0; //The y offset of which to draw Link's sprite.
jumping = false; //Is Link jumping?
z = 0; //How high off of the ground, in pixels, Link is.
zmax = 0; //How high off of the ground, in pixels, Link needs to reach.
zspd = 0; //How fast is Link rising/falling, in pixels?
pushing = false; //Is Link pushing?
//How long, in frames, has Link been pushing?
pushtmr = 0;
//Is Link holding up an item?  0 for 1 hand, 1 for 2 hands.
holding = 0;
slashing = false; //Is Link slashing?
charge = 0; //How long, in frames, has Link been charging.
tap = false; //Is Link tapping his sword against something?
tapreverse = false; //Is Link recovering from tapping the sword?
tapdly = 0; //How long, in frames, Link has to wait before tapping again.
spin = 0; //How many spin attacks has Link done.
rolling = false; //Is Link rolling?
smokedly = 0; //Delay before another smoke object is made.
cliff = false; //Is Link jumping down a cliff or not?
cliffdir = noone; //Which direction is Link jumping in?
cliffspd = 1; //How fast Link is moving for the cliff jump.
hvel = 0; //Conserve horizontal velocity when against a solid.
vvel = 0; //Conserve vertical velocity when against a solid.
myfriction = .5; //Amount of friction used to slow movement to a halt.
lhspeed = 0; //Conserve horizontal speed when the game is paused.
lvspeed = 0; //Conserve vertical speed when the game is paused.
gravity_direction = 270; //Gravity should point down in sideview areas.
mygravity = .5; //How much gravity Link has.
climbing = false; //Is Link climbing on a ladder?
carrying = false; // Is Link holding something
heldObject = noone;