/*********************************************************************
This script centers the view (camera) on whatever calls it, slowly.
It's a "drag" camera, as it attempts to keep up with whatever is
calling this script per frame, and as it gets closer and closer
to where it needs to be, it slows down.  Just some basic arithmetic.
The parameter is whether or not this should be done instantly.

format:  scr_align_view(instant);
*********************************************************************/

var viewxoff = round(camera_get_view_x(view_camera[0]) + 72 - x);
var viewyoff = round(camera_get_view_y(view_camera[0]) + 64 - y);

if (!argument0) {
  if (abs(viewxoff) != 0) {
    var dis = max(floor(abs(viewxoff) / 4), 1);

    if (viewxoff < 0) {
      camera_set_view_pos(
        view_camera[0],
        camera_get_view_x(view_camera[0] + dis),
        camera_get_view_y(view_camera[0])
      );
    } else {
      camera_set_view_pos(
        view_camera[0],
        camera_get_view_x(view_camera[0] - dis),
        camera_get_view_y(view_camera[0])
      );
    }
  }

  if (abs(viewyoff) != 0) {
    var dis = max(floor(abs(viewyoff) / 4), 1);

    if (viewyoff < 0) {
      camera_set_view_pos(
        view_camera[0],
        camera_get_view_x(view_camera[0]),
        camera_get_view_y(view_camera[0]) + dis
      );
    } else {
      camera_set_view_pos(
        view_camera[0],
        camera_get_view_x(view_camera[0]),
        camera_get_view_y(view_camera[0]) - dis
      );
    }
  }
} else {
  camera_set_view_pos(view_camera[0], x - 72, y - 64);
}

if (camera_get_view_x(view_camera[0]) < 0) {
  camera_set_view_pos(view_camera[0], 0, camera_get_view_y(view_camera[0]));
}

if (camera_get_view_y(view_camera[0]) < 0) {
  camera_set_view_pos(view_camera[0], camera_get_view_x(view_camera[0]), 0);
}

if (
  camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) >
  room_width
) {
  camera_set_view_pos(
    view_camera[0],
    room_width - camera_get_view_width(view_camera[0]),
    camera_get_view_y(view_camera[0])
  );
}

if (
  camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) >
  room_height
) {
  camera_set_view_pos(
    view_camera[0],
    camera_get_view_x(view_camera[0]),
    room_height - camera_get_view_height(view_camera[0])
  );
}
