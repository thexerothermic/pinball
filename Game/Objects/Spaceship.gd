extends RigidBody2D
onready var _animated_sprite = $AnimatedSprite
var health = 5
signal spaceship_destroy

func _ready():
	_animated_sprite.play("enter")

func bumped(body:Node):
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	#Called by the ball when this object is touched by the ball
	if(body is RigidBody2D):
		#play sound
		SoundSystem.play_sound("bump1")
		
		#decrement health
		health = health - 1
		
		#if health == 0, destroy ship
		if (health == 0):
			#play destroy animation
			_animated_sprite.play("destroy")
			
			#send signal
			emit_signal("spaceship_destroy")
			
			#remove ship from scene
			queue_free()	
		#if spaceship was not destroyed
		else:
			#deflect ball
			var randomXVelocity = rng.randf_range(300, 400)
			var randomYVelocity = rng.randf_range(1200, 1600)
			body.linear_velocity+=((body.global_position-self.global_position)+Vector2(randomXVelocity,randomYVelocity)).normalized()*900
			
			#play hit animation  - wiggle may be added later
			_animated_sprite.play("on_hit")
			
		
func _on_AnimatedSprite_animation_finished():
	if(_animated_sprite.animation == "enter"):
		print(self.get_node("CollisionPolygon2D").disabled)
		self.get_node("CollisionPolygon2D").disabled = false
		print(self.get_node("CollisionPolygon2D").disabled)
	if (_animated_sprite.animation == "on_hit"):	
		_animated_sprite.stop()
		_animated_sprite.play("default")

	

