extends Area2D

func _ready():
	connect("body_entered",self,"ball_entered")

func ball_entered(ball_ref:RigidBody2D):
	if(self.visible):
		ball_ref.linear_velocity*=-1.2
		self.hide()
		get_parent().get_parent().target_check()
