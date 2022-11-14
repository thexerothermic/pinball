extends RigidBody2D
onready var _animated_sprite = $AnimatedSprite
const wiggle_duration = 0.25
var initial_position = self.global_position
var health = 5
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	_animated_sprite.play("enter")
func bumped(body:Node):
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	#Called by the ball when this object is touched by the ball
	if(body is RigidBody2D):
		#If it's a ball...
		var randomXVelocity = rng.randf_range(300, 400)
		var randomYVelocity = rng.randf_range(1200, 1600)
		body.linear_velocity+=((body.global_position-self.global_position)+Vector2(randomXVelocity,randomYVelocity)).normalized()*900
		
		#play sound
		SoundSystem.play_sound("bump1")
		
		#decrement health
		health = health - 1
		
		#if health == 0, destroy ship
		if (health == 0):
			#play destroy animation
			_animated_sprite.play("destroy")
			
			#either change singleton or drop ball
			
			#remove ship from scene
			queue_free()
			
		#if spaceship was not destroyed
		#play hit animation  - wiggle may be added later
		_animated_sprite.play("on_hit")
			
		
func _on_AnimatedSprite_animation_finished():
	if(_animated_sprite.animation == "enter"):
		self.get_node("CollisionPolygon2D").disabled = false
	if (_animated_sprite.animation == "on_hit"):	
		_animated_sprite.stop()
		_animated_sprite.play("default")

	

