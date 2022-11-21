extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var effect=preload("res://Game/Objects/WarpEffect.tscn")
var points=150

func bumped(body:Node):
	if(body is RigidBody2D):		#If it's a ball...
		print("entered")
		get_node("../WormholeOut").receive_ball(body)
	var x=effect.instance()
	get_parent().add_child(x)
	x.position=get_node("Node2D").global_position
	get_parent().get_node("UI").addPoints(points)
#	add_child(effect.instance())

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
