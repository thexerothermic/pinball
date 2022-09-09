extends Control

func _ready():
	self.pause_mode=Node.PAUSE_MODE_PROCESS
	for x in get_node("SubMenu").get_children():
		x.pause_mode=Node.PAUSE_MODE_PROCESS
	close()

func _process(delta):
	if(Input.is_action_just_pressed("pause")):
		if(!is_open()):
			open()
		else:
			close()


func is_open():
	return self.visible
func open():
	if(SceneHandler.current_scene.name!="Game"):return
	get_tree().paused=true
	show()
func close():
	if(submenu_is_open()):return
	get_tree().paused=false
	hide()


func resume_click():
	#Load game world...
	if(submenu_is_open()):return
	close()

func options_click():
	#Load options menu...
	open_submenu("Options")

func quit_click():
	#Load credits menu...
	PopupSystem.create_yes_no_popup("Quit to main menu?","Are you sure you want to quit to the main menu? Any unsaved progress will be lost.",self,"confirm_quit")


func confirm_quit():
	SceneHandler.smooth_load_scene("MainMenu")
	close()

func open_submenu(menu_name:String="Options"):
	if(submenu_is_open()):return
	get_node("SubMenu/"+str(menu_name)).open()
func close_submenu(menu_name:String="Options"):
	get_node("SubMenu/"+str(menu_name)).close()

func submenu_is_open():
	#returns true if a submenu is open, otherwise false
	for x in get_node("SubMenu").get_children():
		if(x.visible):return true
	return false
