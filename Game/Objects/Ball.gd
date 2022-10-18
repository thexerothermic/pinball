extends RigidBody2D


var myTimer:Timer
var reset = false
const is_ball = true
var ball_points = 0

func _ready():
	
	SoundSystem.play_sound("new_ball")
	
	self.connect("body_entered",self,"bumped")
	myTimer=Timer.new()                #initializes a copy of a class (an instance)
	add_child(myTimer)                                            #Needs to be added to scene to not be collected as garbage
	myTimer.connect("timeout",self,"challenge")                #Connects the signal to a custom function
	reset_timer()        #Called once to get the timer going

	self.custom_integrator=true
	self.contact_monitor=true
	self.contacts_reported=4


const max_scale=0.95
const min_scale=0.75
func ball_scaling():
	var val=max_scale-min_scale
	var scale_me=self.transform.origin.y/600
	var oh_boy=min_scale+(val*scale_me)
	get_node("Sprite").scale=Vector2(oh_boy,oh_boy)

func _process(delta):
	ball_scaling()

func reset_timer():
	myTimer.wait_time=8
	myTimer.start()

func challenge():
	reset_timer()
#	self.linear_velocity+=Vector2(rand_range(-1000,1000),rand_range(-1000,1000))            #Applies a random force to our ball


func bumped(body:Node):
	#Called when the ball hits an object. The ball is in charge of creating bumped requests on other objects
	if(body.has_method("bumped")):
		body.bumped(self)
	if(body.has_method("get_points")):
		ball_points += body.get_points()
		print("current ball has " + str(ball_points) + " points")
func _integrate_forces(state):
	if(Input.is_action_pressed("place_ball")):
		state.transform.origin=get_viewport().get_mouse_position()
	if(reset):
		reset=false
		state.transform.origin=get_parent().get_node("Launcher").position
	else:
		state.linear_velocity.y+=6
