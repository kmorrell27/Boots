InitializeMovementEntity(0.5, 1, o_solid);

image_speed = 0;
acceleration_ = 0.5;
max_speed_ = 1.5;
facing = Direction.RIGHT;
global.player_health = 4;

enum Direction {
	RIGHT,
	UP,
	LEFT,
	DOWN
}

enum Player {
	MOVE
}

// I hate this but dammit it gets results
sprite_[Player.MOVE, Direction.RIGHT] = s_player_run_right;
sprite_[Player.MOVE, Direction.UP] = s_player_run_up;
sprite_[Player.MOVE, Direction.LEFT] = s_player_run_right;
sprite_[Player.MOVE, Direction.DOWN] = s_player_run_down;