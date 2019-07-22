/*********************************************************************
This script initializes all of the global variables for the items.
These variables store things such as level number, ammo, etc.
*********************************************************************/

/*
Max Hearts Link has.  Every 16 HP is one heart.
*/
global.heartmax = 48;

/*
The remaining hearts Link has.  Start it off equal to the max.
*/
global.hearts = global.heartmax;

//How many Heart Pieces Link is currently carrying.
global.heartpieces = 0;

/*
When Link picks up a permanent heart piece/heart container
(those that don't respawn), they are stored in this array.
*/
global.permheart[50] = false;

//Now initialize that array.
for (i = 0; i < 50; i += 1) {
  global.permheart[i] = false;
}

/*
Which tunic Link has.  0 = Green, 1 = Blue, 2 = Red.  Used for
defense calculations, just like A Link to the Past.  The Blue Tunic
cuts damage taken by 1/2, while the Red Tunic cuts the damage taken
by 3/4ths.
*/
global.tunic = 0;

/*
How many Rupees Link has.  He starts off broke.
*/
global.rupees = 0;

/*
How many Bombs Link has.
*/
global.bombs = 0;

/*
How many Arrows Link has.
*/
global.arrows = 0;

/*
Which wallet does Link have?  Also used to draw a specific subimage
of the HUD Rupee Icon.
*/
global.wallet = 0;

/*
The maximum amount of Rupees that can be carried on each wallet.
*/
global.rupeemax[3] = 0;
global.rupeemax[0] = 255;
global.rupeemax[1] = 511;
global.rupeemax[2] = 999;

/*
The maximum amount of Bombs that can be carried on each bomb bag.
*/
global.bombmax[4] = 0;
global.bombmax[0] = 0;
global.bombmax[1] = 8;
global.bombmax[2] = 56;
global.bombmax[3] = 99;

/*
The maximum amount of Arrows that can be carried on each quiver.
*/
global.arrowmax[4] = 0;
global.arrowmax[0] = 0;
global.arrowmax[1] = 16;
global.arrowmax[2] = 56;
global.arrowmax[3] = 99;

/********************************************************************
Equipment level variables.  0 means it's level 0, but it also
wouldn't be in the inventory if he didn't have it at all.
********************************************************************/
global.sword = 1; //Sword Level.
global.shield = 1; //Shield Level.
global.bombbag = 0; //Which Bomb Bag Link has.
global.quiver = 0; //Which Quiver Link has.
/*
Type of Bombs Link has.  0 for Regular, 1 for Silver, and 2
for Gold.
*/
global.bombtype = 0;
/*
Type of Arrows Link has.  0 for Regular, 1 for Silver, and 2
for Gold.
*/
global.arrowtype = 0;
global.feather = 0; //Roc's Equipment Level.
global.bracelet = 0; //Power Bracelet Level.
global.shovel = 0; //Shovel Level.
global.boomerang = 0; //Boomerang Level.
