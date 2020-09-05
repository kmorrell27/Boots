function scr_enums_init() {
	enum Direction {
	  UP,
	  RIGHT,
	  DOWN,
	  LEFT
	}

	enum Item {
	  SWORD,
	  BOMB,
	  BOW,
	  HAMMER,
	  FEATHER,
	}

	enum Color {
	  WHITE = $f7f7f7,
	  GRAY = $887878,
	  YELLOW = $38d0f8,
	  BLACK = $080808,
	}

	enum Character {
	  BRIAN = 1,
	  ROSA = 2,
	  HAROLD = 4,
	  CAITLIN = 8
	}


	enum Transition {
	  LEFT,
	  RIGHT,
	  UP,
	  DOWN,
	  RECTANGLE,
	  CIRCLE,
	  NONE,
	}


}
