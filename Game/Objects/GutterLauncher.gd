extends AnimatedSprite
export var left_or_right="Left"

var points = 50

func _ready():
	get_node("Area2D").connect("body_entered",self,"ball_entered")
	disable_lever()
func ball_entered(ball_ref):
	ball_ref.linear_velocity.x=0
	ball_ref.linear_velocity.y=-1300
	self.frame=0
	self.play("launch")
	get_parent().get_node("UI").addPoints(points)
	
	SoundSystem.play_sound("boing")
	QuickTimer.create_timer(self,"activate_lever",[],0.2)
	#activate_lever()
	


func activate_lever():
	SoundSystem.play_sound("Lever")
	if(get_parent().has_node("Lever"+left_or_right)):
		get_parent().get_node("Lever"+left_or_right).show()
		#get_node("Lever").collision_layer=1
		get_parent().get_node("Lever"+left_or_right).get_node("CollisionShape2D").disabled=false

func disable_lever():
	if(get_parent().has_node("Lever"+left_or_right)):
		get_parent().get_node("Lever"+left_or_right).hide()
	#	get_parent().get_node("Lever"+left_or_right).collision_layer=0
		get_parent().get_node("Lever"+left_or_right).get_node("CollisionShape2D").disabled=true
