extends Position2D

var hold_ball=false			#Are we holding a ball?

var ball_res=preload("res://Game/Objects/Ball.tscn")


var current_ball:RigidBody2D	#Used to keep reference to the ball we may or may not be holding
var pressure=0



func _ready():#(_delta):
	QuickTimer.create_timer(self,"spawn_ball",[],1)
	get_node("Area2D").connect("body_entered",self,"ball_entered",[])

func spawn_ball():
	#Called by the game to spawn a new ball into the launching chamber
	hold_ball=true
	var x=ball_res.instance()
	x.transform.origin=self.global_position
	get_parent().add_child(x)
	x.reset=true
	current_ball=x
	pressure=0

func _process(delta):
	if(Input.is_action_pressed("launch_ball")&&hold_ball):
		pressure+=400*delta
		if(get_node("Pressure").playing==false):
			get_node("Pressure").play()
		get_node("ProgressBar").visible=true
		get_node("ProgressBar").value=-round(clamp(-pressure-200,-1000,-200)/10)
	if(Input.is_action_just_released("launch_ball")&&hold_ball):
		launch_ball(current_ball)

func launch_ball(ball_ref:RigidBody2D):
	#Called by the player's input to launch the ball
	if(get_node("Pressure").playing==true):
			get_node("Pressure").playing=false
		
	get_node("ProgressBar").visible=false
	hold_ball=false
	ball_ref.reset=false 
	ball_ref.linear_velocity+=Vector2(0,clamp(-pressure-200,-1000,-200)*1.5)
	print("Launch Pressure: "+str(clamp(-pressure-200,-1000,-200)))
	$launcher_sound.play()
	QuickTimer.create_timer(SoundSystem,"play_sound",["pressure_release",".wav",0.4],0.6)
	#SoundSystem.play_sound("pressure_release",".wav",0.5)
	pressure=0

func ball_entered(_ball_ref):
	hold_ball=true
	
