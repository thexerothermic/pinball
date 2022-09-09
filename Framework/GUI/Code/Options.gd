extends Control


func _ready():
	close()
	init_volume_sliders()
	init_connections()
	
func open():
	init_volume_sliders()
	show()
func close():
	hide()




func init_connections():
	get_node("Panel/Contents/Fullscreen").connect("pressed",self,"update_fullscreen")
	get_node("Panel/Contents/MasterVolume").connect("value_changed",self,"update_volume")
	get_node("Panel/Contents/Music").connect("value_changed",self,"update_music_volume")
	get_node("Panel/Contents/SFX").connect("value_changed",self,"update_sfx_volume")

func init_volume_sliders():
	var sfx_volume=Settings.get_setting("sfx_volume")
	var music_volume=Settings.get_setting("music_volume")
	var master_volume=Settings.get_setting("master_volume")
	
	get_node("Panel/Contents/MasterVolume").set_value(master_volume)
	get_node("Panel/Contents/SFX").set_value(sfx_volume)
	get_node("Panel/Contents/Music").set_value(music_volume)
	
	get_node("Panel/Contents/Fullscreen").pressed=Settings.get_setting("fullscreen")

func update_fullscreen():
	Settings.change_setting("fullscreen",get_node("Panel/Contents/Fullscreen").pressed)

func update_volume(val):
	Settings.change_setting("master_volume",val)
func update_music_volume(val):
	Settings.change_setting("music_volume",val)
func update_sfx_volume(val):
	Settings.change_setting("sfx_volume",val)

