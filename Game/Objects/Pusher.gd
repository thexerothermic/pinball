extends Area2D


func _ready():
	connect("body_entered",self,"ball_entered")

func ball_entered(ball_ref):
	ball_ref.linear_velocity=ball_ref.linear_velocity.length()*-self.get_global_transform().y#*150
