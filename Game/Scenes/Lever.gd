extends RigidBody2D


func bumped(body:Node):
	if(body is RigidBody2D):		#If it's a ball...
		print("spaceships incoming")
		
