if (!IsInDestroyedList(id)) {
	InitializeHurtboxEntity();
	depth = -bbox_bottom;
	wall_ = instance_create_layer(x, y, "Instances", o_solid);	
} else {
	instance_destroy();
}