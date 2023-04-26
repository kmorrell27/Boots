event_inherited(); //Call the parent event.

lifted = false;
thrown = false;
//How far, in pixels, does this object need to move on the x plane?
throwx = 0;
//How far, in pixels, does this object need to move on the y plane?
throwy = 0;
z = 0; //How high off of the ground, in pixels, this is.
zpeak = false;
zmax = 0; //How high off of the ground, in pixels, this needs to reach.
zspd = 0; //How fast is this rising/falling, in pixels?
throwspd = 0; //How fast, in pixels, is this object moving?
xoff = 0; // For drawing the destruction
yoff = 0;
durable = false; // Bounce of walls and don't crash on the ground
doesdamage = true; // Hurts enemies
