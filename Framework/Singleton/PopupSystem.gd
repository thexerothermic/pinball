#PopupSystem.gd
#----------------
#Singleton name needs to be PopupSystem to avoid naming conflict
#Quick and easy popup system; designed to work with Godot engine popups


#The behavior here is intentionally functional but simple so it's easy to modify.
#Look at the documentation for dialogs if adding additional functionality
#It's assumed that more complex behaviors will be programmed during
#Game development
#----------------
extends Node

var popup=preload("res://Framework/GUI/Object/Popup.tscn")

func test_drive():
#	create_popup("Title","msg",true)
#	create_yes_no_popup("Bellum Romanum","Gloria Belli non est.",self,"yes_action",true)
	
	pass

func yes_action():
	#Dummy function for testing
	print("yes")

func popup_pause(popup_ref:AcceptDialog):
	popup_ref.pause_mode=Node.PAUSE_MODE_PROCESS
	get_tree().paused=true
	popup_ref.connect("confirmed",self,"popup_unpause")

func popup_unpause():
	get_tree().paused=false

func create_popup(title="Pax Romana",text="quid est hoc?",pause_game=false):
	#This creates a generic "OK" popup; use create_yes_no_popup if you need feedback
	var x=popup.instance()
	x.window_title=title
	x.dialog_text=text
	HUDLayer.add_child(x)
	x.popup_centered(Vector2(200,80))
	x.initialPos=x.rect_position
	if(pause_game&&get_tree().paused==false):
		popup_pause(x)
		x.connect("popup_hide",self,"popup_unpause")

func create_yes_no_popup(title:String,text:String,confirm_handler:Node,confirm_function:String,pause_game=false):
	#This creates a generic "Yes No" popup; does nothing if no is pressed
	#Calls the provided function on the provided object if yes is pressed
	var x=popup.instance()
	x.window_title=title
	x.dialog_text=text
	HUDLayer.add_child(x)
	if(pause_game&&get_tree().paused==false):
		popup_pause(x)
		x.connect("popup_hide",self,"popup_unpause")
	x.add_cancel("No")
	x.get_ok().text="Yes"

	x.connect("confirmed",confirm_handler,confirm_function)
	x.popup_centered(Vector2(200,80))
	x.initialPos=x.rect_position

