if (!processedString) {
  str[page] = scr_format_string(str[page]);
  processedString = true;
}

if (scr_bomb_button_pressed()) {
  if (counter < string_length(str[page])) {
    counter = string_length(str[page]);
    alarm[0] = -1;
  } else {
    if (page < array_length_1d(str) - 1) {
      counter = 0;
      page++;
      alarm[0] = textspd;
      processedString = false;
    } else {
      instance_destroy();
    }
  }
}

if (scr_bomb_button_pressed() && counter == string_length(str[page])) {
  if (page < array_length_1d(str) - 1) {
    counter = 0;
    page++;
    alarm[0] = textspd;
    processedString = false;
  } else {
    instance_destroy();
  }
}
