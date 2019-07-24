enum Direction {
	UP,
	DOWN,
	LEFT,
	RIGHT
}


enum Item {
	SWORD,
	SHIELD,
	BOMB,
	BOW,
	BRACELET,
	FEATHER,
}

scr_item_variables_init(); //Initialize the item variables.
scr_global_variables_init(); //Initialize all of the global variables.

/*
How long, in frames, must the game wait before playing the low
health sound again?
*/
dangersnddly = 0;
heartblendamt = 0; //How much color blending is done on the hearts.
heartblendreverse = false; //Is the color blending going the other way?
//How long to wait, in frames, before the next change in blending.
heartblenddly = 0;
/*
What was the value of Link's hearts before he started healing? -1
for no consideration.
*/
oldhearts = -1;
needmenucurx = 0; //Where does the menu cursor X need to be?
needmenucury = 0; //Where does the menu cursor Y need to be?

instance_create_layer(0, 0, global.playerLayer, objWeather);