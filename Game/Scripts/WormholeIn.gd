extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func bumped(body:Node):
	if(body is RigidBody2D):		#If it's a ball...
		print("entered")
		get_node("../WormholeOut").receive_ball(body)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
