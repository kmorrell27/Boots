///@description create_textevent
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

if (instance_exists(obj_textevent)) {
  exit;
}

var textevent = instance_create_layer(0, 0, global.playerLayer, obj_textevent);

with (textevent) {
  reset_dialogue_defaults();

  switch (argument_count - 1) {
    case 9:
      myEmote = argument[9];
    case 8:
      myEmotion = argument[8];
    case 7:
      myTextCol = argument[7];
    case 6:
      myScripts = argument[6];
    case 5:
      myNextLine = argument[5];
    case 4:
      myTypes = argument[4];
    case 3:
      myTextSpeed = argument[3];
    case 2:
      myEffects = argument[2];
  }
  mySpeaker = argument[1];
  myText = argument[0];

  event_perform(ev_other, ev_user0);
}

return textevent;
