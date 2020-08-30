enum Direction {
	UP = 1,
	RIGHT = 2,
	DOWN = 4,
	LEFT = 8,
}

enum Item {
	SWORD,
	BOMB,
	BOW,
	SHIELD,
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