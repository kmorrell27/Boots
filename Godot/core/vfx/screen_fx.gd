extends CanvasLayer

@onready var anim = $AnimationPlayer

var playing:
	get:
		return anim.is_playing()


func fade_white_in():
	anim.play("FadeWhiteIn")
	await anim.animation_finished
	return true


func fade_white_out():
	anim.play("FadeWhiteOut")
	await anim.animation_finished
	return true
