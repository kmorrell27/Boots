/*
This script will return true if any conditions are met that consider
the game as being paused.
*/

return (
  global.pause || instance_exists(obj_textbox) || instance_exists(objTransition)
);
