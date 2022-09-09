extends RigidBody2D


var myTimer:Timer

func _ready():
	myTimer=Timer.new()                #initializes a copy of a class (an instance)
	add_child(myTimer)                                            #Needs to be added to scene to not be collected as garbage
	myTimer.connect("timeout",self,"challenge")                #Connects the signal to a custom function
	reset_timer()                        #Called once to get the timer going


	self.connect("body_entered",self,"bumped")
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
