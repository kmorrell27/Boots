function scr_reset_weather() {
  /********************************************************************
	This script resets the Weather object to a state of use.
	********************************************************************/

  //Stop any weather sounds.
  audio_stop_sound(objWeather.snd);
  //Reset the weather sound delay.
  objWeather.thunder = false; //Reset the thunder.
  //Reset the thunder fade position.
  objWeather.thunderpoint = false;
  objWeather.thunderalpha = 0; //Reset the thunder alpha.
  //Reset the thunder delay to something random.
  objWeather.thunderdly =
    irandom(global.onesecond * 5.5) + global.onesecond / 2;
}
