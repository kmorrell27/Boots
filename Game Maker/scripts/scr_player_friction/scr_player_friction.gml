function scr_player_friction(argument0) {
  /********************************************************************
	This script applies friction to the player, in that it slows their movement
	down until it reaches 0 in each plane.  If the parameter is false,
	then it'll only slow the movement in the plane that isn't used.
	So for example, if the player is heading straight down, friction
	will be applied to the horizontal (x) plane if the parameter is false.

	format:  scr_player_friction(allplanes);
	********************************************************************/

  /*******************************************************************
	HORIZONTAL FRICTION SECTION
	*******************************************************************/
  if (argument0 || (!argument0 && !left && !right)) {
    if (hspeed != 0) {
      if (hspeed < 0) {
        hspeed += myfriction - ((myfriction * 3) / 4) * jumping;
      } else {
        hspeed -= myfriction - ((myfriction * 3) / 4) * jumping;
      }

      if (hspeed >= -0.25 && hspeed <= 0.25) {
        hspeed = 0;
      }
    }
    if (hvel != 0) {
      if (hvel < 0) {
        hvel += myfriction - ((myfriction * 3) / 4) * jumping;
      } else {
        hvel -= myfriction - ((myfriction * 3) / 4) * jumping;
      }

      if (hvel >= -0.25 && hvel <= 0.25) {
        hvel = 0;
      }
    }
  }

  /*******************************************************************
	VERTICAL FRICTION SECTION
	*******************************************************************/
  if ((argument0 || (!argument0 && !down && !up)) && !global.sideview) {
    if (vspeed != 0) {
      if (vspeed < 0) {
        vspeed += myfriction - ((myfriction * 3) / 4) * jumping;
      } else {
        vspeed -= myfriction - ((myfriction * 3) / 4) * jumping;
      }

      if (vspeed >= -0.25 && vspeed <= 0.25) {
        vspeed = 0;
      }
    }
  }
  if (argument0 || (!argument0 && !down && !up)) {
    if (vvel != 0) {
      if (vvel < 0) {
        vvel += myfriction - ((myfriction * 3) / 4) * jumping;
      } else {
        vvel -= myfriction - ((myfriction * 3) / 4) * jumping;
      }

      if (vvel >= -0.25 && vvel <= 0.25) {
        vvel = 0;
      }
    }
  }
}
