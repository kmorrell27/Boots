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
What was the value of the player's hearts before they started healing? -1
for no consideration.
*/
oldhearts = -1;

instance_create_layer(0, 0, global.playerLayer, objWeather);
