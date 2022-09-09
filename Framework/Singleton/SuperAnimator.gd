#SuperAnimate
#-------------------------
#"Super" singletons will not be paused even if the game is paused by the user.
#Otherwise, functionality is the same as their normal, non-super counterparts.
#----------------------------

extends "res://Framework/Singleton/Animator.gd"

func _ready():
	tween_res=load("res://Framework/Singleton Dependencies/SuperTween.tscn")
	self.pause_mode=Node.PAUSE_MODE_PROCESS
