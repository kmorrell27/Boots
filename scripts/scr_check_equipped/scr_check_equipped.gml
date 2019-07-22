/********************************************************************
This script checks to see if Link has a specific item selected on
Z or X.  Useful for checking to see if he has a shield equipped, so
he can use his shield sprites, for example.

format:  scr_check_equipped(item);
*********************************************************************/

//If Link does have the item on Z or X, then he has it equipped.
return (global.Y == argument0 || global.X == argument0);
