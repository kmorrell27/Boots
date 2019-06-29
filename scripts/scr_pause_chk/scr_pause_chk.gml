/*
This script will return true if any conditions are met that consider
the game as being paused.
*/

return (global.pause || global.menuanchor != 0 || instance_exists(objTextBox));
