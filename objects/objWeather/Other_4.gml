if (global.rain) {
  if (global.inside) {
    snd = sndRainInside;
    audio_play_sound(sndRainInside, 10, true);
  } else {
    snd = sndRainOutside;
    audio_play_sound(sndRainOutside, 10, true);
  }
}
