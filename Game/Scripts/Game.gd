extends Node2D
var spaceship_scene = preload("res://Game/Objects/Spaceship.tscn")
var ball_scene = preload("res://Game/Objects/Ball.tscn")
const spaceship_positions = [Vector2(402,297), Vector2(460,158)]
var living_spaceships = spaceship_positions.size()
signal reset_lever
var live_balls = 1

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

func on_spaceship_destroy(spaceship_position):
	living_spaceships = living_spaceships - 1
	if living_spaceships == 0:
		emit_signal("reset_lever")
		living_spaceships = spaceship_positions.size()
		var thread = Thread.new()
		thread.start(self, "_add_ball", spaceship_position)
		
func _add_ball(position):
	OS.delay_msec(20)
	var ball = ball_scene.instance()
	ball.position = position
	add_child(ball)
	live_balls += 1
		
		
