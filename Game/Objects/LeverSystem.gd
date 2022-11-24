extends Area2D

var up=true


signal lever_down
signal lever_up

export var lever_sound="pressure_release"

func _ready():
	connect("body_entered",self,"ball_entered")
	var game = get_owner()
	game.connect("reset_lever", self, "on_reset_lever")
	$LeverArrow.turn_on()
	
func ball_entered(ball_ref):
	
	switch()
	

func switch():
	if(up):
		get_node("AnimationPlayer").play("Down")
		up=false
		emit_signal("lever_down")
		$LeverArrow.turn_off()
		SoundSystem.play_sound(lever_sound)
	#elif(!up):
		#get_node("AnimationPlayer").play("Up")
		#up=true
		#emit_signal("lever_up")

func on_reset_lever():
	print("signal emitted")
	get_node("AnimationPlayer").play("Up")
	up=true
	$LeverArrow.turn_on()
