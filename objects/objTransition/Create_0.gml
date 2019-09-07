/// @description  Initialize Variables
// Transition Variables

enum Transition {
  LEFT,
  RIGHT,
  UP,
  DOWN,
  RECTANGLE,
  CIRCLE,
  NONE,
}

next_room = room;
kind_ = Transition.LEFT;
step_ = 0;
time_ = global.onesecond / 2;

/// Surfaces
surf_start = surface_create(
  surface_get_width(application_surface),
  surface_get_height(application_surface)
);
surf_end = surface_create(
  surface_get_width(application_surface),
  surface_get_height(application_surface)
);

surface_set_target(surf_start);
gpu_set_blendenable(false);
gpu_set_colorwriteenable(true, true, true, false);
draw_clear(c_black);
draw_surface(application_surface, 0, 0);
gpu_set_blendenable(true);
gpu_set_colorwriteenable(true, true, true, true);
surface_reset_target();
