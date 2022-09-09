extends AcceptDialog


#This script moves the popup back to it's original position after being moved.

var initialPos : Vector2

func _ready():
	SoundSystem.play_sound("GUI/popup",".ogg")
	self.connect("popup_hide",self,"close_sound")
	initialPos = self.get_position()

func close_sound():
		SoundSystem.play_sound("GUI/button_press",".ogg")


func _input(event):
	if event is InputEventMouseMotion:
		self.set_position(initialPos)
