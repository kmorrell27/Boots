// 60 FPS baby
global.onesecond = 60;

/*********************************************************************
These variables are storing the IDs of the rooms in each direction.
-1 means there is no room, so the player cannot move to another sector and
will just walk against the edge.
*********************************************************************/

global.southroom = -1;
global.northroom = -1;
global.westroom = -1;
global.eastroom = -1;

/********************************************************************
the player's x/y coordinates just before entering a warp, and the view's
x/y coordinates just before entering a warp.
********************************************************************/
global.lastplayerx = 0;
global.lastplayery = 0;
global.lastviewx = 0;
global.lastviewy = 0;

/********************************************************************
General Globals
********************************************************************/
/*
Where is the HUD located (Y Position)?  Positive value for the top
of the screen, negative value for the bottom.
*/
global.hudanchor = 0;
global.heartblend = Color.WHITE; //The color blend for the hearts.
global.heal = 0; //How much healing (or damaging) the player is undergoing.
global.pause = false; //Is the game paused?
global.inside = true; //Is the player NOT on the overworld?
global.areaname = ""; //The name of the area the player is currently in.
/*
How many frames (also used for position) left for showing the area
name on the screen.
*/
global.showarea = 0;
/*
Is it raining or not?  Even if it is, if the player is not on the
overworld, 'll only hear the inside rain sounds.
*/
global.rain = true;
/*

/*
Are sideview physics used or not?  Sideview areas like on the GBC
Zelda titles.
*/
global.sideview = false;

/*
Make a sprite font so we can use Oracle game font, starting from the
exclamation point.  Then set it as the default drawing
font.
*/

var stringOrder =
  "!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~";
global.font = font_add_sprite_ext(sprFont, stringOrder, false, 0);
draw_set_font(global.font);

/*
Make another sprite font so we can use Oracle game font, starting from
the exclamation point.  It's also a condensed font, so the letters
are put closer together (not mono-spaced).
*/
global.tightfont = font_add_sprite_ext(sprFont, stringOrder, true, 2);

/*
Looking up layers by string is for chumps.
*/
global.textLayer = layer_get_id("Text");
global.playerLayer = layer_get_id("Player");
display_set_gui_size(256, 144);

/*
 * We've got characters!
 */
global.player = Character.CAITLIN;
global.playerid = noone;

global.sprites = [
  [sprBrianUp, sprBrianRight, sprBrianDown, sprBrianLeft],
  [sprRosaUp, sprRosaRight, sprRosaDown, sprRosaLeft],
  [sprHaroldUp, sprHaroldRight, sprHaroldDown, sprHaroldLeft],
  [sprCaitlinUp, sprCaitlinRight, sprCaitlinDown, sprCaitlinLeft]
];

global.heartmax = 48;
global.hearts = global.heartmax;
global.rupees = 0;
