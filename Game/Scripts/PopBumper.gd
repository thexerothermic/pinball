extends RigidBody2D

func bumped(body:Node):
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	#Called by the ball when this object is touched by the ball
	if(body is RigidBody2D):
		#If it's a ball...
		var randomXVelocity = rng.randf_range(300, 400)
		var randomYVelocity = rng.randf_range(300, 400)
		body.linear_velocity+=((body.global_position-self.global_position)+Vector2(randomXVelocity,randomYVelocity)).normalized()*900
		get_parent().get_node("UI").addPoints(100)
