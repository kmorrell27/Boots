/* Goodness this whole script is garbage. At some point we need
 * to figure out a better way of doing this for moving and jumping
 * I guess. Store the current character as a global and then sixteen
 * switch statements? D:
 */
//If Link isn't doing anything specific...
if (
  pushtmr < global.onesecond / 4 &&
  !holding &&
  !rolling &&
  !slashing &&
  !charge &&
  !jumping &&
  !shooting &&
  !hammering
) {
  /*
    If Link isn't flagged as isMoving, use his idle sprites.  Otherwise,
    use his walking sprites.
    */
  
  if (!isMoving) {
    switch (dir) {
      case Direction.DOWN:
        sprite_index = sprLink0ID;
        break;
      case Direction.UP:
        sprite_index = sprLink0IU;
        break;
      case Direction.LEFT:
        sprite_index = sprLink0IL;
        break;
      case Direction.RIGHT:
        sprite_index = sprLink0IR;
        break;
    }
  } else {
    switch (dir) {
      case Direction.DOWN:
        sprite_index = sprLink0WD;
        break;
      case Direction.UP:
        sprite_index = sprLink0WU;
        break;
      case Direction.LEFT:
        sprite_index = sprLink0WL;
        break;
      case Direction.RIGHT:
        sprite_index = sprLink0WR;
        break;
    }
  }
} else if (
  pushtmr >= global.onesecond / 4 &&
  !rolling &&
  !holding &&
  !slashing &&
  !charge &&
  !jumping &&
  !shooting &&
  !hammering
) {
  /*
    Otherwise, if Link is specifically pushing, use his pushing
    sprites.
    */
  switch (dir) {
    case Direction.UP:
      sprite_index = sprLink0PU;
      break;
    case Direction.DOWN:
      sprite_index = sprLink0PD;
      break;
    case Direction.LEFT:
      sprite_index = sprLink0PL;
      break;
    case Direction.RIGHT:
      sprite_index = sprLink0PR;
      break;
  }
} else if ((shooting || slashing || hammering) && !holding && !charge) {
  /*
    Otherwise if Link is specifically slashing his sword
    */
  switch (dir) {
    case Direction.LEFT:
      sprite_index = sprLink0SL;
      break;
    case Direction.UP:
      sprite_index = sprLink0SU;
      break;
    case Direction.RIGHT:
      sprite_index = sprLink0SR;
      break;
    case Direction.DOWN:
      sprite_index = sprLink0SD;
      break;
  }
} else if (charge && !holding) {
  /*
    Otherwise if Link is specifically charging his sword
    */
  switch (dir) {
    case Direction.DOWN:
      sprite_index = sprLink0CHD;
      break;
    case Direction.RIGHT:
      sprite_index = sprLink0CHR;
      break;
    case Direction.LEFT:
      sprite_index = sprLink0CHL;
      break;
    case Direction.UP:
      sprite_index = sprLink0CHU;
      break;
  }
} else if ((jumping || rolling) && !holding) {
  /*
    Otherwise if Link is specifically jumping or rolling, use his
    jumping sprites.
    */
  switch (dir) {
    case Direction.DOWN:
      sprite_index = sprLink0JD;
      break;
    case Direction.RIGHT:
      sprite_index = sprLink0JR;
      break;
    case Direction.LEFT:
      sprite_index = sprLink0JL;
      break;
    case Direction.UP:
      sprite_index = sprLink0JU;
      break;
  }
} else if (holding) {
  /*
    Otherwise if Link is specifically holding up an item, use his
    holding up sprite.
    */
  switch (holding) {
    case 1:
      sprite_index = sprLink0H1;
      break;
    case 2:
      sprite_index = sprLink0H2;
      break;
  }
}
