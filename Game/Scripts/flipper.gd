extends Node

onready var flipper_right = $"Flipper"
onready var flipper_left = $"Flipper2"
var min_right = 0
var min_left = 180
var max_right = 90
var max_left = 90
var right_deg = 0
var left_deg = 0
var speed = 400
func _ready():
	flipper_right.rotation_degrees=right_deg
	flipper_left.rotation_degrees=left_deg

func _process(delta):
#right flipper script
	if(Input.is_action_pressed("right_flipper")&&right_deg<max_right):
		right_deg+=delta*speed
		flipper_right.rotation_degrees=right_deg
	elif(right_deg>min_right):
		right_deg-=delta*speed
		flipper_right.rotation_degrees=right_deg

#left flipper script
	if(Input.is_action_pressed("left_flipper")&&left_deg>max_left):
		left_deg-=delta*speed
		flipper_left.rotation_degrees=left_deg
	elif(left_deg<min_left):
		left_deg+=delta*speed
		flipper_left.rotation_degrees=left_deg

