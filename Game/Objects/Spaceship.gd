extends RigidBody2D

const wiggleDuration = 0.25
var initial_position = self.global_position

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func bumped(body:Node):
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	#Called by the ball when this object is touched by the ball
	if(body is RigidBody2D):
		#If it's a ball...
		var randomXVelocity = rng.randf_range(300, 400)
		var randomYVelocity = rng.randf_range(1200, 1600)
		body.linear_velocity+=((body.global_position-self.global_position)+Vector2(randomXVelocity,randomYVelocity)).normalized()*900
		
		
		SoundSystem.play_sound("bump1")

		SoundSystem.play_sound("pop_bumper_hit")
		#play hit animation and make ship wiggle a little
		#decrement health
		#if health == 0, destroy ship func
#on signal emitted, place spaceships in scene: will use true bool for now
	#play entrance animation
	#play base animation
#destroy ship func
	#play destruction animation
	#remove node from scene
	#cause new ball to enter scene or update a singleton
func _integrate_forces(state):
	print("hj")
	#move in direction oppsite of where ball hit with certain duration and speed
	

