extends CanvasLayer

@onready var anim: AnimationPlayer = $AnimationPlayer

var playing: bool:
	get:
		return anim.is_playing()

func fade_white_in() -> bool:
	anim.play("FadeWhiteIn")
	await anim.animation_finished
	return true

func fade_white_out() -> bool:
	anim.play("FadeWhiteOut")
	await anim.animation_finished
	return true
