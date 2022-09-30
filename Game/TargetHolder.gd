extends Node2D

func target_check():
	if(all_targets_down()):
		reset()
	else:
		print("A Target still remains")


func reset():
	print("All targets down, resetting")
	for x in get_node("Targets").get_children():
		QuickTimer.create_timer(x,"activate",[],1)
		#x.show()
	

func all_targets_down():
	#Returns true if all targets down, false otherwise
	for x in get_node("Targets").get_children():
		if(x.visible):
			print("This is visible:" +str(x.name))
			return false
	return true
