extends Node2D
#var save_nodes = get_tree().get_nodes_in_group("Leaderboard")


func _ready():
	$Score.set_text(SceneHandler.get_score())

func _on_PlayAgain_pressed():
	SceneHandler.quick_load_scene("Game")

"""
func save():
	var save_dict = {
	"filename" : get_filename(),
	"parent" : get_parent().get_path(),
	"player_name" : pname,
	"player_score" :  score,
	}
	return save_dict

func save_game():
	var save_game = file.new()
	save_game.open("res://Framework/saves/leaderboard.save", File.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Leaderboard")
	
	for node in save_nodes:
		# Check the node is an instanced scene so it can be instanced again during load.
		if node.filename.empty():
			print("persistent node '%s' is not an instanced scene, skipped" % node.name)
			continue

		# Check the node has a save function.
		if !node.has_method("save"):
			print("persistent node '%s' is missing a save() function, skipped" % node.name)
			continue

		# Call the node's save function.
		var node_data = node.call("save")

		# Store the save dictionary as a new line in the save file.
		save_game.store_line(to_json(node_data))
	save_game.close()
	
func load_game():
	var save_game = file.new()
	if not save_game.file_exists("res://Framework/saves/leaderboard.save"):
		return
		
	var save_nodes = get_tree().get_nodes_in_group("leaderboard")
	for i in save_nodes:
		i.queue_free()
		
	save_game.open("res://Framework/saves/leaderboard.save")
	while save_game.get_position() < save_game.get_len():
		var node_data = parse_json(save_game.get_line())
		
	var new_object = load(node_data["filename"]).instance()
	get_node(node_data)
"""



