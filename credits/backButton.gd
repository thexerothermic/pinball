extends Node2D

func _ready():
	var backButton = $back
	backButton.connect("pressed", self, "_back_button_pressed")

func _back_button_pressed():
	get_tree().change_scene("res://MainMenu/MainMenu.tscn")
