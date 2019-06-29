event_inherited(); //Call the parent code.

//If Link has picked this up, but hasn't used it yet....
if (got && !used) {
  //Get the L2 Tunic.
  if (global.tunic < 1) {
    global.tunic = 1;
  }
  //Now flag this item as having been used.
  used = true;
}
