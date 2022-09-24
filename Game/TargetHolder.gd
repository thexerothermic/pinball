extends Node2D

func target_check():
	if(all_targets_down()):
		reset()


func reset():
	print("All targets down, resetting")
	for x in get_node("Targets").get_children():
		x.show()
	

func all_targets_down():
	#Returns true if all targets down, false otherwise
	for x in get_node("Targets").get_children():
		if(x.visible):
			return false
	return true
