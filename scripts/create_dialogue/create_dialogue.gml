///@description create_dialogue
///@arg Text
///@arg Speaker
///@arg *Effects
///@arg *Speed
///@arg *Type
///@arg *Next_Line
///@arg *Scripts
///@arg *Text_Col
///@arg *Emotion
///@arg *Emote

if (instance_exists(obj_textbox)) {
  exit;
}

//Create the Textbox
var _textbox = instance_create_layer(x, y, "Text", obj_textbox);

//Get arguments
var _text = argument[0];
var _speaker, text_len;

//If Text or Speaker aren't arrays (single line input), make them arrays
if (is_array(_text)) {
  text_len = array_length_1d(_text);
} else {
  text_len = 1;
  _text[0] = _text;
}
if (!is_array(argument[1])) {
  _speaker = array_create(text_len, id);
} else {
  _speaker = argument[1];
}

//Get rest of arguments, fill with default
var _effects = array_create(text_len, [1, 0]);
var _speed = array_create(text_len, [1, 0.5]);
var _textcol = array_create(text_len, [1, c_white]);
var _type = array_create(text_len, 0);
var _nextline = array_create(text_len, 0);
var _script = array_create(text_len, 0);
var _emotion = array_create(text_len, 0);
var _emotes = array_create(text_len, -1);
var _creator = array_create(text_len, id);

var a;
//Fill variables depending on argument count
switch (argument_count - 1) {
  case 9:
    a = argument[9];
    if (array_length_1d(a) != text_len) {
      a[text_len] = 0;
    }
    for (i = 0; i < text_len; i++) {
      if (a[i] != 0) _emotes[i] = a[i];
    }
  case 8:
    a = argument[8];
    if (array_length_1d(a) != text_len) {
      a[text_len] = 0;
    }
    for (i = 0; i < text_len; i++) {
      if (a[i] != 0) _emotion[i] = a[i];
    }
  case 7:
    a = argument[7];
    if (array_length_1d(a) != text_len) {
      a[text_len] = 0;
    }
    for (i = 0; i < text_len; i++) {
      if (a[i] != 0) _textcol[i] = a[i];
    }
  case 6:
    a = argument[6];
    if (array_length_1d(a) != text_len) {
      a[text_len] = -1;
    }
    for (i = 0; i < text_len; i++) {
      if (a[i] != -1) _script[i] = a[i];
    }
  case 5:
    a = argument[5];
    if (array_length_1d(a) != text_len) {
      a[text_len] = 0;
    }
    for (i = 0; i < text_len; i++) {
      if (a[i] != 0) _nextline[i] = a[i];
    }
  case 4:
    a = argument[4];
    if (array_length_1d(a) != text_len) {
      a[text_len] = 0;
    }
    for (i = 0; i < text_len; i++) {
      if (a[i] != 0) _type[i] = a[i];
    }
  case 3:
    a = argument[3];
    if (array_length_1d(a) != text_len) {
      a[text_len] = 0;
    }
    for (i = 0; i < text_len; i++) {
      if (a[i] != 0) _speed[i] = a[i];
    }
  case 2:
    a = argument[2];
    if (array_length_1d(a) != text_len) {
      a[text_len] = 0;
    }
    for (i = 0; i < text_len; i++) {
      if (a[i] != 0) _effects[i] = a[i];
    }
}

//Change the Textbox Values
with (_textbox) {
  creator = _creator;
  effects = _effects;
  text_speed = _speed;
  type = _type;
  text = _text;
  nextline = _nextline;
  executeScript = _script;
  text_col = _textcol;
  emotion = _emotion;
  emotes = _emotes;

  //Speaker's Variables
  for (var i = 0; i < text_len; i++) {
    portrait[i] = _speaker[i].myPortrait;
    voice[i] = _speaker[i].myVoice;
    font[i] = _speaker[i].myFont;
    name[i] = _speaker[i].myName;
    speaker[i] = _speaker[i];

    if (variable_instance_exists(_speaker[i], "myPortraitTalk")) {
      portrait_talk[i] = _speaker[i].myPortraitTalk;
    } else {
      portrait_talk[i] = -1;
    }
    if (variable_instance_exists(_speaker[i], "myPortraitTalk_x")) {
      portrait_talk_x[i] = _speaker[i].myPortraitTalk_x;
    } else {
      portrait_talk_x[i] = -1;
    }
    if (variable_instance_exists(_speaker[i], "myPortraitTalk_y")) {
      portrait_talk_y[i] = _speaker[i].myPortraitTalk_y;
    } else {
      portrait_talk_y[i] = -1;
    }
    if (variable_instance_exists(_speaker[i], "myPortraitIdle")) {
      portrait_idle[i] = _speaker[i].myPortraitIdle;
    } else {
      portrait_idle[i] = -1;
    }
    if (variable_instance_exists(_speaker[i], "myPortraitIdle_x")) {
      portrait_idle_x[i] = _speaker[i].myPortraitIdle_x;
    } else {
      portrait_idle_x[i] = -1;
    }
    if (variable_instance_exists(_speaker[i], "myPortraitIdle_y")) {
      portrait_idle_y[i] = _speaker[i].myPortraitIdle_y;
    } else {
      portrait_idle_y[i] = -1;
    }

    if (portrait_talk[i] != -1) {
      portrait_talk_n[i] = sprite_get_number(portrait_talk[i]);
      portrait_talk_s[i] = sprite_get_speed(portrait_talk[i]) / room_speed;
    }
    if (portrait_idle[i] != -1) {
      portrait_idle_n[i] = sprite_get_number(portrait_idle[i]);
      portrait_idle_s[i] = sprite_get_speed(portrait_idle[i]) / room_speed;
    }
  }

  draw_set_font(font[0]);
  charSize = string_width("M");
  stringHeight = string_height("M");
  event_perform(ev_alarm, 0); //makes textbox perform "setup"
}

myTextbox = _textbox;
return _textbox;
