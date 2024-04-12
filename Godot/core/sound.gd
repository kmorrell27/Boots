extends Node

var playing: Dictionary = {}
var index: int = 0

func play(sound: AudioStream) -> int:
	var audio: AudioStreamPlayer = AudioStreamPlayer.new()
	audio.stream = sound
	audio.volume_db = -25
	audio.finished.connect(audio.queue_free)
	add_child(audio)
	audio.play()
	playing[index] = audio
	index += 1
	return index - 1

func stop(id: int) -> void:
	var audio: AudioStreamPlayer = playing[id]
	audio.stop()
	_on_finish(id)
	pass

func _on_finish(id: int) -> void:
	var audio: AudioStreamPlayer = playing[id]
	playing.erase(id)
	audio.queue_free()
