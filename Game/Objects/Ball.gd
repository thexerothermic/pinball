extends RigidBody2D


var myTimer:Timer
var reset = false
const is_ball = true
func _ready():

	self.connect("body_entered",self,"bumped")
	myTimer=Timer.new()                #initializes a copy of a class (an instance)
	add_child(myTimer)                                            #Needs to be added to scene to not be collected as garbage
	myTimer.connect("timeout",self,"challenge")                #Connects the signal to a custom function
	reset_timer()        #Called once to get the timer going

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
	myTimer.wait_time=4
	myTimer.start()

func challenge():
	reset_timer()
	self.linear_velocity+=Vector2(rand_range(-1000,1000),rand_range(-1000,1000))            #Applies a random force to our ball

func bumped(body:Node):
	#Called when the ball hits an object. The ball is in charge of creating bumped requests on other objects
	if(body.has_method("bumped")):
		body.bumped(self)
func _integrate_forces(state):
	if(reset):
		reset=false
		state.transform.origin=Vector2(400,400)
	
