event_inherited(); //Call the parent code.

//If Link has picked this up, but hasn't used it yet....
if (got && !used) {
  //Get the L3 Tunic.
  if (global.tunic < 2) {
    global.tunic = 2;
  }
  //Now flag this item as having been used.
  used = true;
}
