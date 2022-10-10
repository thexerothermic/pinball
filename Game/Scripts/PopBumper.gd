extends RigidBody2D
onready var _animated_sprite = $AnimatedSprite
const points = 50
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
		_animated_sprite.play("activate")
		SoundSystem.play_sound("pop_bumper_hit")
#returns how many points this target is worth for upgrade calculation
func get_points():
	return points


func _on_AnimatedSprite_animation_finished():
	_animated_sprite.stop()
	_animated_sprite.play("default")
