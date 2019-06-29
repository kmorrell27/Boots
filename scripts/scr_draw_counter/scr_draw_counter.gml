/*********************************************************************
This script draws a counter at some given position.

format:  scr_draw_counter(value,maxdigits,xpos,ypos,blend,alpha);
*********************************************************************/

/*
First, make a variable for our temporary string we'll be working
with.
*/
var tempstr = "";

/*
Nex let's make a variable to see how many zero's we'll need, and
a loop counter.
*/

var zeros = argument1 - string_length(string(argument0));
var i = 0;

//While we still need more zeros.
while (i < zeros) {
  tempstr += "0"; //Add them to the temporary string.
  i += 1; //And increment the counter.
}

/*
Finally, add the remaining value onto the temporary string, and
reset the counter.
*/
tempstr += string(argument0);
i = 0;

/*
Now loop through the string, and draw each digit with the formatting
passed into this script.
*/

for (i = 0; i < string_length(tempstr); i += 1) {
  draw_sprite_ext(
    sprHUDDigits,
    real(string_copy(tempstr, i + 1, 1)),
    argument2 + 8 * i,
    argument3,
    image_xscale,
    image_yscale,
    image_angle,
    argument4,
    argument5
  );
}
