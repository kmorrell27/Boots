//If Link was holding this when it was destroyed...
if (got) {
  //If Link has the requisite heart pieces, give him a container.
  if (global.heartpieces >= 4) {
    instance_create_layer(objLink.x, objLink.y, global.playerLayer, objHeartContainer);
    global.heartpieces = 0; //Then reset the heart pieces.
  }
}
