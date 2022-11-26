extends Area2D
var game
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("body_entered",self,"reset_ball")
	game = get_owner()
func reset_ball(body:Node):
	
	SoundSystem.play_sound("ball_crash")
	body.queue_free()
	game.live_balls -= 1
	
	if(game.live_balls == 0):
		QuickTimer.create_timer(get_parent().get_node("Launcher"),"spawn_ball",[],1)
	#	get_parent().get_node("Launcher").spawn_ball()
		get_parent().get_node("UI").sub_life()
		game.live_balls = 1

