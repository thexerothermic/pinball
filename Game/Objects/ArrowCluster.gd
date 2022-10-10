extends Node2D


var index=0
var arrows=[]

var cd=0.25

export var reset_cd=0.25

func _ready():
	set_process(false)
	for x in get_children():
		arrows.append(x)
	arrows[index].turn_on()
	set_process(true)

func _process(delta):
		cd-=delta
		if(cd<=0):
			cd=reset_cd
			alternate_arrows()

func alternate_arrows():
	arrows[index].turn_off()
	index+=0.5
	if(index==arrows.size()):
		index=0
	arrows[index].turn_on()
