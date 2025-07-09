if (startOffset < travelDistance * 16) {
  switch (dir) {
    case Direction.RIGHT:
      x += 1;
      break;
    case Direction.LEFT:
      x -= 1;
      break;
    case Direction.UP:
      y -= 1;
      break;
    case Direction.DOWN:
      y += 1;
      break;
  }
  startOffset++;
} else {
  startOffset = 0;
  dir += 2;
  dir = dir % 4;
}
