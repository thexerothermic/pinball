extends Position2D

var hold_ball=false			#Are we holding a ball?

var ball_res=preload("res://Game/Objects/Ball.tscn")


var current_balls=[]	#Used to keep reference to the ball we may or may not be holding
var pressure=0



func _ready():#(_delta):
	QuickTimer.create_timer(self,"spawn_ball",[],1)
	get_node("Area2D").connect("body_entered",self,"ball_entered",[])


func has_ball_ref(ball_ref):
	for x in current_balls:
		if(x==ball_ref):
			return true
	return false
func add_ball_ref(ball_ref):
	if(!has_ball_ref(ball_ref)):
		current_balls.append(ball_ref)

func clear_ball_refs():
	current_balls=[]


	
func spawn_ball():
	#Called by the game to spawn a new ball into the launching chamber
	hold_ball=true
	var x=ball_res.instance()
	x.global_position=self.global_position
	get_parent().add_child(x)
	x.reset=true
	add_ball_ref(x)
#	current_ball=x
	pressure=0
	
	get_parent().get_node("GutterLauncherLeft").disable_lever()
	get_parent().get_node("GutterLauncherRight").disable_lever()
	
	
	

func _process(delta):
	if(Input.is_action_pressed("launch_ball")&&hold_ball):
		pressure+=400*delta
		if(get_node("Pressure").playing==false):
			get_node("Pressure").play()
		get_node("ProgressBar").visible=true
		get_node("ProgressBar").value=-round(clamp(-pressure-200,-1000,-200)/10)
	if(Input.is_action_just_released("launch_ball")&&hold_ball):
		launch_ball()

func check_ball(ball_ref):
	if(get_node("Area2D").overlaps_body(ball_ref)):
		add_ball_ref(ball_ref)
		hold_ball=true
	

func launch_ball():
	#Called by the player's input to launch the ball
	if(get_node("Pressure").playing==true):
			get_node("Pressure").playing=false
		
	get_node("ProgressBar").visible=false
	hold_ball=false
	
	for x in current_balls:
	
		x.reset=false 
		x.linear_velocity=Vector2(0,clamp(-pressure-200,-1000,-400)*1.5)
		QuickTimer.create_timer(self,"check_ball",[x],0.25)

	clear_ball_refs()
	print("Launch Pressure: "+str(clamp(-pressure-200,-1000,-200)))
	$launcher_sound.play()
	QuickTimer.create_timer(SoundSystem,"play_sound",["pressure_release",".wav",0.4],0.6)
	pressure=0

func ball_entered(ball_ref):
	hold_ball=true
	add_ball_ref(ball_ref)
	
