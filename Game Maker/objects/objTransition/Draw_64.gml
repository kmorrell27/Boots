/// @description Transition
//We create the temporary variables containing the gui width and height for easy access.
var width, height, x1, y1, x2, y2;
width = display_get_gui_width();
height = display_get_gui_height();

if (room != next_room) {
  room_goto(next_room);
}
switch (kind_) {
  case Transition.RIGHT:
    x1 = (1 - step_ / time_) * width;
    y1 = 0;
    x2 = (-step_ / time_) * width;
    y2 = 0;
    break;
  case Transition.LEFT:
    x1 = (-1 + step_ / time_) * width;
    y1 = 0;
    x2 = (step_ / time_) * width;
    y2 = 0;
    break;
  case Transition.DOWN:
    x1 = 0;
    y1 = (1 - step_ / time_) * height;
    x2 = 0;
    y2 = (-step_ / time_) * height;
    break;
  case Transition.UP:
    x1 = 0;
    y1 = (-1 + step_ / time_) * height;
    x2 = 0;
    y2 = (step_ / time_) * height;
    break;
  case Transition.RECTANGLE:
    scr_tr_rectangle(surf_start, surf_end, width, height, step_ / time_);
    exit;
  case Transition.CIRCLE:
    scr_tr_circle(surf_start, surf_end, width, height, step_ / time_);
    exit;
}

draw_surface_stretched(surf_end, x1, y1, width, height);
draw_surface_stretched(surf_start, x2, y2, width, height);
