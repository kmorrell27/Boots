/// @description Insert description here
// You can write your code in this editor
draw_self();
var xoff = x + 6;
var yoff = y + 6;
//Ahahaha this is bonkers that it's indexed from 1
for (var i = 1; i <= counter; i++) {
	if (string_char_at(str[page], i) != "\n") {
		draw_text(xoff, yoff, string_char_at(str[page], i));
		xoff += 8;
	} else {
		xoff = x + 4;
		yoff += 8
	}
}

if (counter == string_length(str[page])) {
	draw_sprite(sprTextBoxContinue, 0, xoff, yoff);
	alarm[0] = -1;
}