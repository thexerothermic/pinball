#SuperQuickTimer
#-------------------------
#"Super" singletons will not be paused even if the game is paused by the user.
#Otherwise, functionality is the same as their normal, non-super counterparts.
#----------------------------

extends "res://Framework/Singleton/QuickTimer.gd"

func _ready():
	self.pause_mode=Node.PAUSE_MODE_PROCESS
