extends Node2D

func _ready():
	var playButton = $Play
	var optionsButton = $settings
	var creditsButton = $credits
	var quitButton = $quit
	playButton.connect("pressed", self, "_play_button_pressed")
	optionsButton.connect("pressed", self, "_options_button_pressed")
	creditsButton.connect("pressed", self, "_credits_button_pressed")
	quitButton.connect("pressed", self, "_quit_button_pressed")
	
	
func _play_button_pressed():
	get_tree().change_scene("res://MainGame/game.tscn")

func _options_button_pressed():
	get_tree().change_scene("res://options/options.tscn")

func _credits_button_pressed():
	get_tree().change_scene("res://credits/credits.tscn")

func _quit_button_pressed():
	get_tree().quit()
