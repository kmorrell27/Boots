/// @description  Transition
step_++;

if (step_ > time_) { instance_destroy(); }

if (!surface_exists(surf_start) || !surface_exists(surf_end)) {
    if (room != next_room) { room_goto(next_room); }
    instance_destroy();
}