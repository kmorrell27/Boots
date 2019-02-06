InitializeMovementEntity(0.5, 1, o_solid);
InitializeHurtboxEntity();

image_speed = 0;
acceleration_ = 0.5;
max_speed_ = 1.5;
roll_speed_ = 2;
direction_facing_ = Direction.RIGHT;
roll_direction_ = Direction.RIGHT;
found_item_sprite_ = noone;

enum Direction {
	RIGHT,
	UP,
	LEFT,
	DOWN
}

enum PlayerState {
	MOVE,
	SWORD,
	EVADE,
	BOMB,
	BOW,
	FOUND_ITEM,
	HIT
}

state_ = PlayerState.MOVE;

// I hate this but dammit it gets results
sprite_[PlayerState.MOVE, Direction.RIGHT] = s_player_run_right;
sprite_[PlayerState.MOVE, Direction.UP] = s_player_run_up;
sprite_[PlayerState.MOVE, Direction.LEFT] = s_player_run_right;
sprite_[PlayerState.MOVE, Direction.DOWN] = s_player_run_down;

sprite_[PlayerState.SWORD, Direction.RIGHT] = s_player_attack_right;
sprite_[PlayerState.SWORD, Direction.LEFT] = s_player_attack_right;
sprite_[PlayerState.SWORD, Direction.UP] = s_player_attack_up;
sprite_[PlayerState.SWORD, Direction.DOWN] = s_player_attack_down;

sprite_[PlayerState.EVADE, Direction.RIGHT] = s_player_roll_right;
sprite_[PlayerState.EVADE, Direction.LEFT] = s_player_roll_right;
sprite_[PlayerState.EVADE, Direction.UP] = s_player_roll_up;
sprite_[PlayerState.EVADE, Direction.DOWN] = s_player_roll_down;

sprite_[PlayerState.HIT, Direction.RIGHT] = s_player_run_right;
sprite_[PlayerState.HIT, Direction.UP] = s_player_run_up;
sprite_[PlayerState.HIT, Direction.LEFT] = s_player_run_right;
sprite_[PlayerState.HIT, Direction.DOWN] = s_player_run_down;

sprite_[PlayerState.FOUND_ITEM, Direction.RIGHT] = s_player_found_item;
sprite_[PlayerState.FOUND_ITEM, Direction.UP] = s_player_found_item;
sprite_[PlayerState.FOUND_ITEM, Direction.LEFT] = s_player_found_item;
sprite_[PlayerState.FOUND_ITEM, Direction.DOWN] = s_player_found_item;

sprite_[PlayerState.BOMB, Direction.RIGHT] = s_player_run_right;
sprite_[PlayerState.BOMB, Direction.UP] = s_player_run_up;
sprite_[PlayerState.BOMB, Direction.LEFT] = s_player_run_right;
sprite_[PlayerState.BOMB, Direction.DOWN] = s_player_run_down;