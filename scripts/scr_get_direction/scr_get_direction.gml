///@arg direction
switch (argument0) {
  case Direction.DOWN:
    return "D";
    break;
  case Direction.UP:
    return "U";
    break;
  case Direction.LEFT:
    return "L";
    break;
  case Direction.RIGHT:
    return "R";
    break;
  default:
    show_error("Unknown direction: " + argument0, false);
    break;
}
