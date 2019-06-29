/*********************************************************************
This script draws text at the position with the given formatting,
and outlined with the given color.

format:  scr_outline_text(x,y,text,color,outlinecolor,alpha);
********************************************************************/

draw_text_color(
  argument0 + 1,
  argument1,
  string_hash_to_newline(argument2),
  argument4,
  argument4,
  argument4,
  argument4,
  argument5
);
draw_text_color(
  argument0,
  argument1 + 1,
  string_hash_to_newline(argument2),
  argument4,
  argument4,
  argument4,
  argument4,
  argument5
);
draw_text_color(
  argument0 - 1,
  argument1,
  string_hash_to_newline(argument2),
  argument4,
  argument4,
  argument4,
  argument4,
  argument5
);
draw_text_color(
  argument0,
  argument1 - 1,
  string_hash_to_newline(argument2),
  argument4,
  argument4,
  argument4,
  argument4,
  argument5
);
draw_text_color(
  argument0,
  argument1,
  string_hash_to_newline(argument2),
  argument3,
  argument3,
  argument3,
  argument3,
  argument5
);
