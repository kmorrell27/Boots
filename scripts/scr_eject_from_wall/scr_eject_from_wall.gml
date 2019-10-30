	/* Start at 0 degrees and make a gradually growing circle until we find a pixel
	that's not in the wall, then move there. */
	var magnitude = 1;
	var _x = x;
	var _y = y;
	var step = 0;
	
	while (place_meeting(_x, _y, objSolid)) {
	  _x = x;
	  _y = y;
	  switch(step) {
		 case 0:
		   _x += magnitude;
		   break;
		 case 1:
		   _x += magnitude;
		   _y += magnitude;
		   break;
		 case 2:
		   _y += magnitude;
		   break;
		 case 3:
		   _x -= magnitude;
		   _y += magnitude;
		   break;
		 case 4:
		   _x -= magnitude;
		   break;
		 case 5:
		   _x -= magnitude;
		   _y -= magnitude;
		   break;
		 case 6:
		   _y -= magnitude;
		   break;
		 case 7:
		   _x += magnitude;
		   _y -= magnitude;
		   break;
	    }
		step++;
		step = step % 8;
		if (step == 0) {
		  magnitude++;
		}
	  }
	  x = _x;
	  y = _y;