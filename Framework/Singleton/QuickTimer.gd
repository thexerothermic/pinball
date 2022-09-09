#QuickTimer.gd
#--------------------------
#Provides quick, easy and simple timing functions.
#For instance, you might want something to happen at a particular time after something else...this helps with that.
#Without this, you have to manually setup the timer (or equivalent) yourself
#--------------------------

extends Node

#
func create_timer(ref_object, ref_function = "", ref_binds = [], ref_time = 1.0, one_shot = true, x:Timer = null, times:int = 1):
	# Creates a timer with the given properties
	# Timer, x, can be passed in case outside code needs to stop or change it
	# times: number of times this timer will execute. NA when one_shot
	if (x == null):
		x = Timer.new()
	add_child(x)
	
	x.connect("timeout", ref_object, ref_function, ref_binds)
	if (one_shot):
		x.set("one_shot", true)
		x.connect("timeout",x,"queue_free")
	else:
		if (times > 1): # if the timer is executing more than once
			create_timer(self, "", [x], ref_time * times)
			print (ref_time * times)
	x.wait_time = ref_time
	x.start()
	return x # Return timer in case in needs to be accessed later
