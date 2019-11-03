moveable = true; //Is the player ABLE to move?
isMoving = false; //Is the player moving?
spd = 0.5; //How fast, in pixels, does the player increase their movement speed?
maxspd = 1; //Maximum amount of speed the player can achieve.
//Which direction is the player facing?  D=Down, U=Up, L=Left, R=Right.
dir = Direction.DOWN;
/*
Which direction has the player pressed?  This will be used for
double tapping a directional key.
*/
doublekeytapdir = noone;
doublekeytapdly = 0; //Frames left before double tapping interval ends.
xoff = 0; //The x offset of which to draw the player's sprite.
yoff = 0; //The y offset of which to draw the player's sprite.
jumping = false; //Is the player jumping?
z = 0; //How high off of the ground, in pixels, the player is.
zmax = 0; //How high off of the ground, in pixels, the player needs to reach.
zspd = 0; //How fast is the player rising/falling, in pixels?
pushing = false; //Is the player pushing?
//How long, in frames, has the player been pushing?
pushtmr = 0;
slashing = false; //Is the player slashing?
charge = 0; //How long, in frames, has the player been charging.
tap = false; //Is the player tapping their sword against something?
tapreverse = false; //Is the player recovering from tapping the sword?
tapdly = 0; //How long, in frames, the player has to wait before tapping again.
spin = 0; //How many spin attacks has the player done.
rolling = false; //Is the player rolling?
smokedly = 0; //Delay before another smoke object is made.
cliff = false; //Is the player jumping down a cliff or not?
cliffdir = noone; //Which direction is the player jumping in?
cliffspd = 1; //How fast the player is moving for the cliff jump.
hvel = 0; //Conserve horizontal velocity when against a solid.
vvel = 0; //Conserve vertical velocity when against a solid.
myfriction = 0.5; //Amount of friction used to slow movement to a halt.
lhspeed = 0; //Conserve horizontal speed when the game is paused.
lvspeed = 0; //Conserve vertical speed when the game is paused.
gravity_direction = 270; //Gravity should point down in sideview areas.
mygravity = 0.5; //How much gravity the player has.
climbing = false; //Is the player climbing on a ladder?
carrying = false; // Is the player holding something
heldObject = noone;
shooting = false; // I'm gonna reuse this for the hookshot
hammering = false; // Maybe this could be consolidated idk
bombing = false;

shader = shader_get_uniform(sh_saturation, "Degree"); // control shader
active = true;

party = 15;
partySize = 4;
inactiveSprite = -1;

global.playerid = id;
