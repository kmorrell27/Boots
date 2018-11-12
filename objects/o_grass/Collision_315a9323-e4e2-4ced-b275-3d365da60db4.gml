if (HurtboxEntityCanBeHitBy(other)) {
	instance_destroy();
	CreateAnimationEffect(s_grass_effect, x, y, random_range(0.4, 0.8), true);
}