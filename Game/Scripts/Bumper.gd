extends RigidBody2D

const points = 50 #how many points this target is worth
var animation_played = false
var floatingPoints = preload("res://Game/Objects/FloatingPoints.tscn")



func bumped(body:Node):
	#Called by the ball when this object is touched by the ball
	if(body is RigidBody2D):		#If it's a ball...
	#	body.linear_velocity*=-0.95
		var posit=body.transform.origin
		if(posit.distance_to(get_node("Other1").global_position)<posit.distance_to(get_node("Band").global_position)):
			return
		if(posit.distance_to(get_node("Other2").global_position)<posit.distance_to(get_node("Band").global_position)):
			return
		body.linear_velocity+=((body.global_position-self.global_position)+Vector2(0,-35)).normalized()*420
		if(body.linear_velocity.length()<550):
			body.linear_velocity*=(550/body.linear_velocity.length())
		play_bump_animation()
		

func play_bump_animation():
	get_node("AnimationPlayer").play("bump")
	SoundSystem.play_sound("bump2")
	get_parent().get_node("UI").addPoints(points)
	#make floating text
	var text = floatingPoints.instance()
	text.amount = points
	add_child(text)
	animation_played = true
#returns how many points this target is worth for upgrade calculation
func get_points():
	if(animation_played):
		return points
		animation_played = false
	else:
		return 0
