/// @description room_goto_transition(room, transition, [steps]);
/// @param room
/// @param  transition
/// @param  [steps]
function scr_room_transition() {
  with (instance_create_layer(0, 0, global.playerLayer, objTransition)) {
    next_room = argument[0];
    //The room we want to go to.
    kind_ = argument[1];
    //The transition kind we want to use.

    if (argument_count >= 3 && argument[2] > 0) {
      time_ = argument[2];
      //The amount of steps our transition will transpire (default is 30).
    }
  }
}
