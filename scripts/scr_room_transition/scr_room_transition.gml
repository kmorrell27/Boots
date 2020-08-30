/// @description room_goto_transition(room, transition, [steps]);
/// @param room
/// @param  transition
/// @param  [steps]
function scr_room_transition() {
  with (instance_create_layer(0, 0, global.playerLayer, objTransition)) {
    next_room = argument[0];
    kind_ = argument[1];

    if (argument_count >= 3 && argument[2] > 0) {
      //The amount of steps our transition will transpire (default is 30).
      time_ = argument[2];
    }
  }
}
