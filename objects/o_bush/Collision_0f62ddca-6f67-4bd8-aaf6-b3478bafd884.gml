if (HurtboxEntityCanBeHitBy(other)) {
	instance_destroy();
	instance_destroy(wall_);
	CreateAnimationEffect(s_bush_effect, x, y, 1, true);
	AddToDestroyedList(id);
}