extends RigidBody2D

var ball_class = get_script()
var myTimer:Timer
var reset = false
const is_ball = true
var ball_points = 0
var go_through_wormhole = false
var rng = RandomNumberGenerator.new()


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
	if(body.has_method("bumped") and !(body is ball_class)):
		body.bumped(self)
	#if(body.has_method("get_points")):
	#	ball_points += body.get_points()
	#	print("current ball has " + str(ball_points) + " points")
var max_vel=2000
func _integrate_forces(state):
	
	if(state.linear_velocity.length()>max_vel):
		state.linear_velocity*=(max_vel/state.linear_velocity.length())
	#	maxa=state.linear_velocity.length()
#		print("Max "+(str(maxa)))
	var con=state.get_contact_count()
	if(con>0):
		if(state.get_contact_collider_object(0).name=="left_flipper"||state.get_contact_collider_object(0).name=="right_flipper"):
			print(state.get_contact_collider_velocity_at_position(0))
		#	state.linear_velocity-=state.get_contact_collider_velocity_at_position(0)
			if(state.get_contact_collider_velocity_at_position(0).y<0):
				state.linear_velocity+=state.get_contact_collider_velocity_at_position(0)*Vector2(0.3,0.5)
				state.integrate_forces()
	if(Input.is_action_pressed("place_ball")):
		state.linear_velocity=Vector2(0,0)
		state.transform.origin=get_viewport().get_mouse_position()
	if(reset):
		reset=false
		state.transform.origin=get_parent().get_node("Launcher").position
	else:
		state.linear_velocity.y+=3.5
	if(go_through_wormhole):
		state.linear_velocity = Vector2(0,0)
		state.set_transform(Transform2D(0,get_node("../WormholeOut").position))
		get_node("Trail").clear_points()
		QuickTimer.create_timer(get_node("Trail"),"clear_points",[],0.01)
		QuickTimer.create_timer(get_node("Trail"),"clear_points",[],0.02)
		QuickTimer.create_timer(get_node("Trail"),"clear_points",[],0.03)
		QuickTimer.create_timer(get_node("Trail"),"clear_points",[],0.04)
		state.set_linear_velocity(Vector2(rng.randf_range(400,420),rng.randf_range(369,400)))
		go_through_wormhole = false
		
