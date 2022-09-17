extends KinematicBody2D

export var action:String="left_flipper"
export var min_deg = 0
export var max_deg = 90
export var speed = 900
var play_sfx = true

func _process(delta):
	if(Input.is_action_pressed(action)):
		rotation_degrees+=delta*speed
		if(play_sfx):
			$flipper_sound.play()
			play_sfx = false
	else:
		rotation_degrees-=delta*speed
		play_sfx = true
	rotation_degrees=clamp(rotation_degrees,min_deg,max_deg)
