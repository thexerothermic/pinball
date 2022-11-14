extends Node2D
var spaceship_scene = preload("res://Game/Objects/Spaceship.tscn")
const spaceship_positions = [Vector2(402,297), Vector2(460,158)]
var living_spaceships = spaceship_positions.size()
signal reset_lever

func _ready():
	SoundSystem.play_music("Soulbringer-SpaceBlockbuster")
	var lever_system = get_node("LeverSystem")
	lever_system.connect("lever_down", self, "_on_lever_down")

func _on_lever_down():
	for position in spaceship_positions:
		var spaceship = spaceship_scene.instance()
		spaceship.position = position
		add_child(spaceship)
		spaceship.connect("spaceship_destroy", self, "on_spaceship_destroy")

func on_spaceship_destroy():
	living_spaceships = living_spaceships - 1
	if living_spaceships == 0:
		print("reset lever")
		emit_signal("reset_lever")
		living_spaceships = spaceship_positions.size()
		#could place code here for multiball
		
