audio_play_sound(sndBush, 10, false); //Play the bush sound.

//Temporary variable for the id of the leaf object we'll make 8 times.
var leaf = -1;

/*
Temp. variable to make sure that at least one component of the speed
for the leaves isn't zero.
*/
var usedzero = false;
//Let's create a total of 8 leaves from this bush.
for (var i = 0; i < 8; i += 1) {
  //

  //First, make the leaf object, and store it.
  leaf = instance_create_layer(x + 4, y + 4, global.playerLayer, objLeaf);
  leaf.sprite_index = leafspr;
  //Give it the needed sprite.
  //Give it a random subimage.
  leaf.image_index = irandom(7);
  //Give it a random needed horizontal speed.
  leaf.horspd = random(1);
  //50/50 chance to go the other way horizontally.
  if (irandom(1) == 0) {
    leaf.horspd *= -1;
  }
  //If it was to be 0, let's flag that so the next one can't be.
  if (leaf.horspd == 0) {
    usedzero = true;
  }
  //Give it a random needed vertital speed.
  leaf.verspd = random(1 - 0.5 * usedzero) + 0.5 * usedzero;
  //50/50 chance to go the other way vertically.
  if (irandom(1) == 0) {
    leaf.verspd *= -1;
  }

  //Reset the check for zero.
  usedzero = false;
}

//1 in 8 chance to get an item.
if (irandom(7) == 1) {
  //Make a random item at the bush's location.
  var item = scr_random_item(x + 4, y);

  //Give the item any momentum the bush had before it was destroyed.
  item.hspeed = hspeed;
  item.vspeed = vspeed;
}
