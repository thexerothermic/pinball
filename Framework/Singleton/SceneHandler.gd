#SceneHandler.gd
#------------------
#The scene handler loads game levels/scenes (game menu screens, literal game levels)

#smooth_load_scene should be used if you want a loading screen
#if you just want a scene quickly loaded as fast possible, use quick_load_scene

#Make sure the scene prefix points to wherever the game's scenes/levels are stored
#------------------
extends Node

var scene_suffix=".tscn"
var scene_prefix="res://Game/Scenes/"
var current_scene
var res_loader=null
var poll_cd=0.2
var scene_instance
var score = "0"

func _ready():
	current_scene=get_tree().get_root().get_child(get_tree().get_root().get_child_count()-1)

func activate():
	set_process(true)
func deactivate():
	set_process(false)

func _process(delta):
#	print("processing..")
	if(res_loader==null):
#		print("res loader is null")
		set_process(false)
	else:
		if(!poll_cd<0):
			poll_cd-=delta
		else:
			poll_cd=0.1
			var polling=res_loader.poll()
			if(polling==ERR_FILE_EOF):
				get_tree().get_root().get_node("LoadingScreen/ProgressBar").update_bar(100)
				poll_cd=0.45

				HUDLayer.transition_fade()


				SuperQuickTimer.create_timer(self,"dump_scene",[],0.4)
			elif(polling==OK):
				get_tree().get_root().get_node("LoadingScreen/ProgressBar").update_bar(float(float(res_loader.get_stage())/float(res_loader.get_stage_count()))*100)
			else:
				res_loader=null
				set_process(false)
				
				#print("Error loading resource...")
func dump_scene():
	clear_current_scene()
#	res_loader.poll()
	var scene_instance=res_loader.get_resource().instance()
				
	get_tree().get_root().add_child(scene_instance)
	current_scene=scene_instance
	res_loader=null
	
	#GUIEffects.create_fade(0)
func clear_current_scene():
	if(current_scene!=null):
		print("clearing current scene -> "+current_scene.get_name())
		current_scene.queue_free()
		current_scene=null
func quick_load_scene(scene_name):
	clear_current_scene()
	var scene_instance=load(scene_prefix+scene_name+scene_suffix).instance()
	get_tree().get_root().add_child(scene_instance)
	current_scene=scene_instance
func smooth_load_scene(scene_name):
	
	if(get_tree().paused):
		get_tree().paused=false
	#Call this function to load in a scene gradually with a loading screen shown between loads
	#GUIEffects.create_fade(1)
	HUDLayer.transition_fade()
	SuperQuickTimer.create_timer(self,"smooth_load_scene2",[scene_name],0.7)
func smooth_load_scene2(scene_name):
	#Do not call this function! Call Smooth load scene! 
	quick_load_scene("LoadingScreen")
	if(get_tree().get_root().has_node("LoadingScreen/Label")):
		get_tree().get_root().get_node("LoadingScreen/Label").set_text("Loading "+scene_name)
	#GUIEffects.create_fade(0)
	res_loader=ResourceLoader.load_interactive(scene_prefix+scene_name+scene_suffix)
	if(res_loader==null):
		print("Resource Loading Error - Failed to load this scene  ---> "+scene_name)
		return
	set_process(true)
func process_stuff():
	set_process(true)
	
func set_score(var temp):
	score = temp
func get_score() -> String:
	return score
