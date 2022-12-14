extends StaticBody2D

#func _ready():
#	connect("body_entered",self,"ball_entered")

#func ball_entered(ball_ref:RigidBody2D):
var hit_effect_ref=preload("res://Game/Objects/NewTargetHitEffect.tscn")
const points = 250 #how many points this target is worth
var floatingPoints = preload("res://Game/Objects/FloatingPoints.tscn")

func create_hit_effect(ball_ref):
	var x=hit_effect_ref.instance()
	x.global_position=self.global_position
	get_parent().get_parent().get_parent().add_child(x)
	x.look_at(ball_ref.global_position)
	
func activate():
	self.show()
	get_node("CollisionShape2D").set_deferred("disabled",false)
#	get_node("CollisionShape2D").disabled=false

func bumped(ball_ref:RigidBody2D):
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	create_hit_effect(ball_ref)
	
	if(self.visible):
#		ball_ref.linear_velocity*=-1.2
		var randomXVelocity = rng.randf_range(100, 200)
		var randomYVelocity = rng.randf_range(100, 200)
		ball_ref.linear_velocity-=((ball_ref.global_position-self.global_position)+Vector2(randomXVelocity,randomYVelocity)).normalized()*450
		
		self.hide()
#		get_node("CollisionShape2D").disabled=true
		get_node("CollisionShape2D").set_deferred("disabled",true)
		
		get_parent().get_parent().target_check()
		
		get_tree().get_root().get_node("Game").get_node("UI").addPoints(points)
		#add floating text as points
		var text = floatingPoints.instance()
		text.amount = points
		text.position=ball_ref.global_position#-Vector2(350,50)
		get_parent().get_parent().get_parent().call_deferred("add_child",text)
		SoundSystem.play_sound("target_hit")
