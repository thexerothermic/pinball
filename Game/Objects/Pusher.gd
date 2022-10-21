extends Area2D


func _ready():
	connect("body_entered",self,"ball_entered")

func ball_entered(ball_ref):
	
#	if(ball_ref.linear_velocity.length()>100):
#	print("Here ",str(ball_ref.linear_velocity.normalized().angle_to(self.get_global_transform().y)))
#	print("Here ",str(ball_ref.linear_velocity.normalized().angle_to(-self.get_global_transform().y)))

	#if(ball_ref.linear_velocity.angle_to(-self.get_global_transform().y)<0.8):
	#print(-self.global_transform.y)

	var x=ball_ref.linear_velocity.normalized()
	#print(x)
	
	#print(rad2deg(self.global_transform.y.angle_to(x)))
	if(abs(rad2deg(self.global_transform.y.angle_to(x)))>100):
		ball_ref.linear_velocity=ball_ref.linear_velocity.length()*-self.get_global_transform().y#*150
	#else:
#	else:
