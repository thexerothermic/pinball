extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func receive_ball(body:Node):
	if(body is RigidBody2D):
		body.go_through_wormhole = true
		SoundSystem.play_sound("Wormhole")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
