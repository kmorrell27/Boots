event_inherited(); //Call the parent event.
hold = 2; //Hold this with two hands.
//Use the Heart Container sound when Link holds this.
getsnd = sndHeartContainer;
/*
Which array index to use for the permanent storing of obtaining.
-1 for respawning item.
*/
heartnum = -1;

/*
If this isn't a respawning item, and it has been obtained before,
delete it.
*/
if (heartnum > -1) {
  if (global.permheart[heartnum]) {
    instance_destroy();
  }
}
