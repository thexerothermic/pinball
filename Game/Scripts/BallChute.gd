extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("body_entered",self,"reset_ball")
func reset_ball(body:Node):
	$chute_sound.play()
#	body.set("reset",true)
	body.queue_free()
	QuickTimer.create_timer(get_parent().get_node("Launcher"),"spawn_ball",[],1)
#	get_parent().get_node("Launcher").spawn_ball()


#	print("attempt reset")
#	print(body.reset)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
