if (!processedString) {
  str[page] = scr_format_string(str[page]);
  processedString = true;
}

if (keyboard_check_pressed(global.hammerButton)) {
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
