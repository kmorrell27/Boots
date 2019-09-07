event_inherited(); //Call the parent code.

//If Link has picked this up, but hasn't used it yet....
if (got && !used) {
  //Add 1 to the total Heart Pieces.
  global.heartpieces += 1;
  
  //Flag this item as having been obtained, if possible.
  if (heartnum > -1) {
    global.permheart[heartnum] = true;
  }
  //Now flag this item as having been used.
  used = true;
}
