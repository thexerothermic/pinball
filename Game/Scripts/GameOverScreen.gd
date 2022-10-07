extends Node2D

func _ready():
	$Score.set_text(SceneHandler.get_score())

func _on_PlayAgain_pressed():
	SceneHandler.quick_load_scene("Game")
