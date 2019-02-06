event_inherited();
image_speed = 0;
image_index = 1;
depth = -bbox_bottom;

if (IsInDestroyedList(id)) {
	image_index = 0;
	activatable_ = false;
}