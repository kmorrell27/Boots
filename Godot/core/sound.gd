extends Node

var playing := {}
var index := 0


func play(sound) -> int:
	var audio := AudioStreamPlayer.new()
	audio.stream = sound
	audio.volume_db = -25
	audio.finished.connect(audio.queue_free)
	add_child(audio)
	audio.play()
	playing[index] = audio
	index += 1
	return index - 1


func stop(id: int) -> void:
	var audio = playing[id]
	audio.stop()
	_on_finish(id)
	pass


func _on_finish(id: int) -> void:
	var audio = playing[id]
	playing.erase(id)
	audio.queue_free()
