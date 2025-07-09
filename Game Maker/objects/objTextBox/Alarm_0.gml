/// @description Insert description here
// You can write your code in this editor
counter = min(counter + 1, string_length(str[page]));
audio_play_sound(
  counter == string_length(str[page]) ? sndTextDone : sndLetter,
  10,
  false
);
alarm[0] = textspd;
