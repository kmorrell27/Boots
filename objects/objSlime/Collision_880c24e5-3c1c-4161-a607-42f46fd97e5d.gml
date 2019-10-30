if (!hitstun && other.thrown) {
  hitstun = true;
  direction = point_direction(objPlayer.x, objPlayer.y, x, y);
  speed = 3;
  
  health = max(health - 1, 0);
  if (health == 0) {
	 alarm[1] = global.onesecond / 10; 
  } else {
    alarm[0] = global.onesecond / 5;
  }
  instance_destroy(other);
}
