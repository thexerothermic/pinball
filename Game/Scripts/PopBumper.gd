extends RigidBody2D
onready var _animated_sprite = $AnimatedSprite
const points = 100


var ballhit_ref=preload("res://Game/Objects/BallHitEffect.tscn")

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

		
		SoundSystem.play_sound("bump1")

		_animated_sprite.play("activate")
		$AnimatedSprite/Light2D.set_enabled(true)
		SoundSystem.play_sound("pop_bumper_hit")
		
		
		var hit_effect=ballhit_ref.instance()
		hit_effect.global_position=body.global_position
		get_parent().add_child(hit_effect)
#returns how many points this target is worth for upgrade calculation
func get_points():
	return points


func _on_AnimatedSprite_animation_finished():
	_animated_sprite.stop()
	$AnimatedSprite/Light2D.set_enabled(false)
	_animated_sprite.play("default")

