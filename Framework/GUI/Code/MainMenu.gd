extends Control


func _ready():
	SoundSystem.play_music("Space Marines",".ogg")
	

func play_click():
	#Load game world...
	if(submenu_is_open()):return
	SceneHandler.smooth_load_scene("Game")

func options_click():
	#Load options menu...
	open_submenu("Options")

func credits_click():
	#Load credits menu...
	open_submenu("Credits")

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
