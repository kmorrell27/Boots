/// @description  Transition
step_++;

if (step_ > time_) {
  instance_destroy();
}

if (!surface_exists(surf_start) || !surface_exists(surf_end)) {
  instance_destroy();
}
