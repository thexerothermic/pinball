extends Node

# Called when the node enters the scene tree for the first time.
func addPoints(points):
	var temp = int($score/score_counter.get_text())
	temp += points
	$score/score_counter.set_text(str(temp))
func sub_life():
	var temp = int($lives/live_counter.get_text())
	temp-=1
	if(temp>0):
		$lives/live_counter.set_text(str(temp))
	else:
		print("final score "+ $score/score_counter.get_text())
		SceneHandler.quick_load_scene("GameOver")
		#get_tree().get_root().get_node("GameOver/score").set_text(str($lives/live_counter.get_text()))
		$score/score_counter.set_text(str(0))
		$lives/live_counter.set_text(str(3))
