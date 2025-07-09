function scr_random_item(argument0, argument1) {
  return instance_create_layer(
    argument0,
    argument1,
    global.playerLayer,
    noone // todo-this will break
  );
}
