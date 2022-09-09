#HUDLayer.gd
#---------------------------
#A canvas layer for nodes that need constant access to drawing on top of the player's screen
#and should not be destroyed between scenes
#in other words; a hud layer

#This singleton provides:
#	transitions (for smoothly loading different scenes/levels)
#		use set_transition to change transition type (vertical_swipe,horizontal_swipe,shards,simple)
#	a persistent HUD layer for loading HUD elements
#---------------------------



extends CanvasLayer
var pause_menu=preload("res://Game/Scenes/PauseMenu.tscn")
func init_framework_hud():
	add_child(pause_menu.instance())




func _ready():
	build_fader()
	fade(1,0)
	self.pause_mode=Node.PAUSE_MODE_PROCESS
	
	init_framework_hud()





#Console implementation
#var console_ref=preload("res://Classes/Menus/Widgets/Console.tscn")
#func _input(event):
#	if(Input.is_action_just_pressed("open_console")&&!has_node("Konsole")):
#		var inst=console_ref.instance()
#		add_child(inst)
#		inst.toggle_console()
#		inst.output_text("Please type in a command...")
#		inst.name="Konsole"







#Implemented fades as a part of the super hud; This is mostly intended for easy, simple transition effects
var death_cd=0
func _process(delta):
	#Essentially runs faders on a "lease/lend" system
	#if the fader object is not used for more than 10 seconds, the fader is deleted.
	#This is done to keep the superHUD clean, because the superHUD draws on top of literally everything
	if(!has_node("Fader")):
		set_process(false)
		return
	else:
		if(get_node("Fader").color.a>0):
			return
		else:
			death_cd-=delta
			if(death_cd<=0):
				get_node("Fader").queue_free()

var shader_res=preload("res://Framework/Singleton Dependencies/TransitionShader.tres")
var horizontal_swipe=preload("res://Framework/Singleton Dependencies/masks/horizontal_swipe.png")
var vertical_swipe=preload("res://Framework/Singleton Dependencies/masks/vertical_swipe.png")
var pinwheel=preload("res://Framework/Singleton Dependencies/masks/Pinwheel.png")
var default_mask=preload("res://Framework/Singleton Dependencies/masks/default.png")

#Transition types
var transition_type="default"
func set_transition(type):
	transition_type=type
	match type:
		"pinwheel":
			pinwheel()
		"vertical_swipe":
			vertical_swipe()
		"horizontal_swipe":
			horizontal_swipe()
		_:
			simple()
func pinwheel():
	if(fader_exists()):get_node("Fader").material.set_shader_param("mask",pinwheel)
func vertical_swipe():
	if(fader_exists()):get_node("Fader").material.set_shader_param("mask",vertical_swipe)
func horizontal_swipe():
	if(fader_exists()):get_node("Fader").material.set_shader_param("mask",horizontal_swipe)
func simple():
	if(fader_exists()):get_node("Fader").material.set_shader_param("mask",default_mask)
func build_fader():
	#Builds a color rectangle to use for fades/transition shader effects
	var color_rect=ColorRect.new()
	color_rect.name="Fader"
#	color_rect.anchor_right=1
	#color_rect.anchor_bottom=1
	var screen_res=get_viewport().size
	color_rect.rect_size=Vector2(0,0)
	color_rect.anchor_right=1
	color_rect.anchor_bottom=1
#	color_rect.rect_size=Vector2(400,300)
	color_rect.color=Color(0,0,0,0)
	color_rect.mouse_filter=Control.MOUSE_FILTER_IGNORE
	color_rect.material=ShaderMaterial.new()
	color_rect.material.shader=shader_res
#	color_rect.material.set("shader_param/blur",0)

	color_rect.material.set_shader_param("cutoff",1)
	color_rect.material.set_shader_param("smooth_size",0.4)		#If using mask, 0.08
	#color_rect.set("shader_param/mask",shards)

	add_child(color_rect)
	set_transition(transition_type)
	




func fader_exists():
	return has_node("Fader")

func fade(amount=1,duration=1):
	#Internal method to create a simple fade effects for (duration) seconds long

	if(!has_node("Fader")):			#Don't have a fader? build one.
		build_fader()
	
	if(get_node("Fader").material.get_shader_param("mask")==default_mask):
#		SuperAnimator.linear_animate(get_node("Fader"),"modulate",Color(0,0,0,1-amount),duration)
	#	SuperAnimator.linear_animate(get_node("Fader").material,"shader_param/cutoff",amount,duration)
		SuperAnimator.linear_animate(get_node("Fader"),"modulate",Color(0,0,0,1-amount),duration)
		get_node("Fader").material.set_shader_param("cutoff",0)
	else:
#	SuperAnimate.linear_animate(get_node("Fader").material,"shader_param/blur",fade_color.a*8,duration)
		SuperAnimator.linear_animate(get_node("Fader").material,"shader_param/cutoff",amount,duration)
	#	print("ABC")
	#	print(get_node("Fader").material.get("shader_param/mask"))
	
	#Starts our countdown, if it's not used within 10 seconds, we'll delete it.
	death_cd=10
	set_process(true)
	

func transition_fade():
	#This is the transition for the scene handler, it does a fast fade in and fade out effect
	fade(0,0.4)			#0 means to fade out (go black), 1 means to fade in (go transparent)
	SuperQuickTimer.create_timer(self,"fade",[1,0.4],0.75)


