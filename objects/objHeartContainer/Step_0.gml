event_inherited(); //Call the parent code.

//If Link has picked this up, but hasn't used it yet....
if (got && !used) {
  //Add 1 container (16) to the Max Hearts.
  global.heartmax += 16;

  //Fully Heal Link.
  scr_heal(global.heartmax - global.hearts);

  //Flag this item as having been obtained, if possible.
  if (heartnum > -1) {
    global.permheart[heartnum] = true;
  }
  //Now flag this item as having been used.
  used = true;
}
