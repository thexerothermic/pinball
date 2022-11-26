extends RigidBody2D
const points = 100


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var effect=preload("res://Game/Objects/WarpEffect.tscn")
var floatingPoints = preload("res://Game/Objects/FloatingPoints.tscn")

func bumped(body:Node):
	if(body is RigidBody2D):		#If it's a ball...
		print("entered")
		get_node("../WormholeOut").receive_ball(body)
	var x=effect.instance()
	get_parent().add_child(x)
	x.position=get_node("Node2D").global_position
	get_parent().get_node("UI").addPoints(100)
	#make floating text
	var text = floatingPoints.instance()
	text.amount = points
	add_child(text)
#	
func get_points():
	return points
