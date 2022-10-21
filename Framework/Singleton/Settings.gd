extends Node

#Multi-Resolution Notes

#Window size != internal resolution

#Internal resolution is defined by the screen stretch settings

var settings={
	"fullscreen":false,
	"sfx_volume":100,
	"music_volume":75,
	"master_volume":100,
	"resolution":Vector2(800,600),
	"input_map_data":[]
	}
var default_settings={
	"fullscreen":false,
	"sfx_volume":100,
	"music_volume":75,
	"master_volume":100,
	"resolution":Vector2(800,600),
	"input_map_data":[]
	}
func fetch_input_map_data():
	#Packages the current input map into an array of dictionaries listing each input action and it's associated events in an array
	var input_map_data=[]
	var actions=InputMap.get_actions()
	for a in actions:
		var action_list_a=InputMap.get_action_list(a)
		input_map_data.append({"action":a,"action_list":action_list_a})
	return input_map_data

func set_input_map_data(input_map_data=[]):
	#Sets the current input map from the given input map data
	clear_input_map_data()
	for def in input_map_data:
		var action=def["action"]
		var action_list=def["action_list"]
		for input_ev in action_list:
			InputMap.action_add_event(action,input_ev)
	settings["input_map_data"]=input_map_data

func clear_input_map_data():
	#Clears input events from all actions in the current input map
	for a in InputMap.get_actions():
		InputMap.action_erase_events(str(a))


func fetch_default_input_map():
	#Sets the default input map data from project settings input map; So this needs to be called before settings are loaded in
	default_settings["input_map_data"]=fetch_input_map_data()


func restore_default_input_map():
	set_input_map_data(default_settings["input_map_data"])
	settings["input_map_data"]=fetch_input_map_data()









func set_resolution(new_width=800,new_height=600):
	ProjectSettings.set("display/window/size/width",new_width)
	ProjectSettings.set("display/window/size/height",new_height)
	var x=Vector2(ProjectSettings.get("display/window/size/width"),ProjectSettings.get("display/window/size/height"))
	get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_2D,SceneTree.STRETCH_ASPECT_KEEP_HEIGHT,x,1)


func save_settings():
	var file_name="Settings"
	var save_file=ConfigFile.new()

	save_file.set_value("Settings", "data", settings)

	save_file.save("res://System/" + file_name)


func load_settings():
	var file_name = "Settings"
	var save_file = ConfigFile.new()
	save_file.load("res://System/" + file_name)

	settings = save_file.get_value("Settings", "data", settings)


	if (settings.size() != default_settings.size()):
		print("SETTINGS ERROR : REPLACING WITH DEFAULTS")
		settings = default_settings.duplicate()
		save_settings()
	
	

func change_setting(setting_to_change,new_value):
	if (settings.has(setting_to_change)):
		settings[setting_to_change] = new_value
		refresh_settings()
	else:
		print("SETTINGS ERROR #1 SETTING NOT FOUND : " + str(setting_to_change))
	


func get_setting(setting_to_get):
	if (settings.has(setting_to_get)):
		return settings[setting_to_get]


func clear_settings():
	settings=default_settings


func refresh_settings():
	OS.window_maximized = false
	OS.window_fullscreen = settings["fullscreen"]

	SoundSystem.set_sfx_volume(settings["sfx_volume"])
	SoundSystem.set_music_volume(settings["music_volume"])
	SoundSystem.set_master_volume(settings["master_volume"])
#	QuickTimer.create_timer(self, "fix_maximize", [], 0.1)
	
#	set_input_map_data(settings["input_map_data"])


func fix_maximize():
	OS.window_maximized = true
func _ready():
	fetch_default_input_map()
	load_settings()
#	SuperQuickTimer.create_timer(self,"refresh_settings",[],1)
	#refresh_settings()
	set_resolution()

