extends Pickup
	
func body_entered(body):
	# Checks if the body name is player and if player has less than 9 keys
	if body.name == "player" && body.get("keys") < 9:
		body.keys += 1
		super.queue_free()

