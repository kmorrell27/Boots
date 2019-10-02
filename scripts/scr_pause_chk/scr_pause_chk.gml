/*
This script will return true if any conditions are met that consider
the game as being paused.
*/

return (
  global.pause || instance_exists(objTextBox) || instance_exists(objTransition)
);
