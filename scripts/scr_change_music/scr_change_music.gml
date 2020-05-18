function scr_change_music(argument0) {
  /*********************************************************************
	This script stops any previous music that was playing, takes the
	parameter (IT HAS TO BE A MUSIC FILE!!!) and loops it as the new
	background music, if it isn't playing already.
	format:  scr_change_music(sound);
	*********************************************************************/

  if (!audio_is_playing(argument0)) {
    if (audio_exists(global.music)) {
      audio_sound_gain(global.music, 0, 2000);
    }
    global.music = argument0;
    audio_sound_gain(argument0, 0.8, 2000);
    audio_play_sound(argument0, 10, true);
  }
}
