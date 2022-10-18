extends AnimatedSprite


func _ready():
	get_node("Area2D").connect("body_entered",self,"ball_entered")
	disable_lever()
func ball_entered(ball_ref):
	ball_ref.linear_velocity.x=0
	ball_ref.linear_velocity.y=4200
	self.frame=0
	self.play("launch")
	
	SoundSystem.play_sound("boing")
	QuickTimer.create_timer(self,"activate_lever",[],0.2)
	#activate_lever()
	


func activate_lever():
	if(has_node("Lever")):
		get_node("Lever").show()
		get_node("Lever").get_node("CollisionShape2D").disabled=false

func disable_lever():
	if(has_node("Lever")):
		get_node("Lever").hide()
		get_node("Lever").get_node("CollisionShape2D").disabled=true
