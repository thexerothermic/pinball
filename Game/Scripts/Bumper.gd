extends StaticBody2D

func bumped(body:Node):
	#Called by the ball when this object is touched by the ball
	if(body is RigidBody2D):		#If it's a ball...
		body.linear_velocity+=((body.global_position-self.global_position)+Vector2(0,1)).normalized()*500
