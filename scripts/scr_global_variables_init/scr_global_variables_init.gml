// 60 FPS baby
global.onesecond = 60;

/*********************************************************************
These variables are storing the IDs of the rooms in each direction.
-1 means there is no room, so Link cannot move to another sector and
will just walk against the edge.
*********************************************************************/

global.southroom = -1;
global.northroom = -1;
global.westroom = -1;
global.eastroom = -1;

/********************************************************************
Link's x/y coordinates just before entering a warp, and the view's
x/y coordinates just before entering a warp.
********************************************************************/
global.lastlinkx = 0;
global.lastlinky = 0;
global.lastviewx = 0;
global.lastviewy = 0;

/********************************************************************
General Globals
********************************************************************/
global.music = -1; //Music that is playing.  -1 for none.
/*
Where is the HUD located (Y Position)?  Positive value for the top
of the screen, negative value for the bottom.
*/
global.hudanchor = 0;
global.heartblend = CL_WHITE; //The color blend for the hearts.
global.Y = noone; //What Item is selected on Z.
global.X = noone; //What Item is selected on X.
global.heal = 0; //How much healing (or damaging) Link is undergoing.
global.rupoff = 0; //How much money Link is gaining (or losing).
global.pause = false; //Is the game paused?
global.menucurx = 0; //The X position of the menu cursor.
global.menucury = 0; //The Y position of the menu cursor.
global.inside = true; //Is Link NOT on the overworld?
global.areaname = ""; //The name of the area Link is currently in.
/*
How many frames (also used for position) left for showing the area
name on the screen.
*/
global.showarea = 0;
/*
Is it raining or not?  Even if it is, if Link is not on the
overworld, he'll only hear the inside rain sounds.
*/
global.rain = true;
/*

/*
Are sideview physics used or not?  Sideview areas like on the GBC
Zelda titles.
*/
global.sideview = false;

/*
Where is the Menu located (Y Position)?  Positive value for the top
of the screen, negative value for the bottom.
*/
global.menuanchor = 0;
global.menupos = 0; //Cursor position in the menu.
/*
Array of what's stored in each slot in the inventory.
*/
global.inventory[30] = noone;
/*
Now initialize that array to blank strings.
*/
for (i = 0; i < 30; i += 1) {
  global.inventory[i] = noone;
}
global.inventory[0] = Item.BOMB;

/*
Array of what chests have been opened.
*/
global.chest[50] = false;
/*
Now initialize that array to unopened chests.
*/
for (i = 0; i < 50; i += 1) {
  global.chest[i] = false;
}

/*
Make a sprite font so we can use Oracle game font, starting from the
exclamation point.  Then set it as the default drawing
font.
*/
global.font = font_add_sprite(sprFont, 33, false, 0);
draw_set_font(global.font);

/*
Make another sprite font so we can use Oracle game font, starting from
the exclamation point.  It's also a condensed font, so the letters
are put closer together (not mono-spaced).
*/
global.tightfont = font_add_sprite(sprFont, 33, true, 2);

/*
Looking up layers by string is for chumps.
*/
global.playerLayer = layer_get_id("Player");
global.groundLayer = layer_get_id("GroundTile");
display_set_gui_size(256, 144);