extends RigidBody2D
onready var _animated_sprite = $AnimatedSprite
var health = 5
var original_position
signal spaceship_destroy
var thread
var invulnerable = false
var wiggle_positive = false
var wiggle_negative = false
var rotate_to_center = false
var hit_effect_ref=preload("res://Game/Objects/TargetHitEffect.tscn")
const points = 250
var floatingPoints = preload("res://Game/Objects/FloatingPoints.tscn")

func _ready():
	thread = Thread.new()
	_animated_sprite.play("enter")
	SoundSystem.play_sound("spaceship_enter")

func bumped(body:Node):
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	#Called by the ball when this object is touched by the ball
	if(body is RigidBody2D):
		if(!self.invulnerable):
			#decrement health if not invulnerable
			health = health - 1
			#add points
			get_parent().get_node("UI").addPoints(points)
			#add floating text as points
			var text = floatingPoints.instance()
			text.amount = points
			add_child(text)
		
		#if health == 0, destroy ship
		if (health == 0):
			#play destroy animation
			
			_animated_sprite.play("destroy")
			
			#play sound
			SoundSystem.play_sound("spaceship_destroy")
			create_hit_effect(body)
			#send signal
			emit_signal("spaceship_destroy", self.position)
			
			#remove ship from scene
			queue_free()	
		#if spaceship was not destroyed
		else:
			#still deflect ball if temporarily invulnerable
			var randomXVelocity = rng.randf_range(300, 400)
			var randomYVelocity = rng.randf_range(1200, 1600)
			body.linear_velocity+=((body.global_position-self.global_position)+Vector2(randomXVelocity,randomYVelocity)).normalized()*900
			#play hit animation and wiggle if not invulnerable
			if(!invulnerable):
				_animated_sprite.play("on_hit")
				wiggle_positive = true
				invulnerable = true
				SoundSystem.play_sound("spaceship_hit")
			
			
		
func _on_AnimatedSprite_animation_finished():
	if(_animated_sprite.animation == "enter"):
		print(self.get_node("CollisionPolygon2D").disabled)
		self.get_node("CollisionPolygon2D").disabled = false
		print(self.get_node("CollisionPolygon2D").disabled)
	if (_animated_sprite.animation == "on_hit"):	
		_animated_sprite.stop()
		_animated_sprite.play("default")
		#Remove invulnerability at end of hit animation

func create_hit_effect(ball_ref):
	var x=hit_effect_ref.instance()
	x.global_position=self.global_position
	get_parent().get_parent().add_child(x)
	x.look_at(ball_ref.global_position)
	
func get_points():
	return points
	
func _physics_process(delta):
	var delta_times_four = delta * 4
	#wiggle spaceship in a third of a second
	if(wiggle_positive):
		rotation += delta_times_four
		if(rotation >= 0.5):
			wiggle_negative = true
			wiggle_positive = false
	elif(wiggle_negative):
		rotation -= delta_times_four
		if (rotation <= -0.5):
			rotate_to_center = true
			wiggle_negative = false
	elif(rotate_to_center):
		rotation += delta_times_four
		if(rotation >= 0):
			rotation = 0
			rotate_to_center = false
			self.invulnerable = false

