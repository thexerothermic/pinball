extends Control
var score_file = "res://Framework/saves/scores.sav"
var name_file = "res://Framework/saves/names.sav"
var highscores = [524288,262144,131072,65536,32768,16384,8192,4096,2048,1024]
var names = ["RB","JF","PH","NS","BM","CS","D2L","JM","KK","EB"]
var newScore = 0
var newHighScore = 0
var newHighScoreCheck = false

func _ready():
	newScore = int(SceneHandler.get_score())
	$Scorebox/Score.set_text(str(newScore))
	load_scores()
	check_new_score()

func _on_PlayAgain_pressed():
	SceneHandler.quick_load_scene("Game")

func load_scores():
	var f1 = File.new()
	var f2 = File.new()
	if f1.file_exists(score_file) && f2.file_exists(name_file):
		f1.open(score_file, File.READ)
		f2.open(name_file, File.READ)
		for n in 10:
			highscores[n] = int(f1.get_line())
			names[n] = f2.get_line()
		f1.close()
		f2.close()
		
func save_scores():
	var f1 = File.new()
	var f2 = File.new()
	
	f1.open(score_file, File.WRITE)
	f2.open(name_file, File.WRITE)
	for n in 10:
		f1.store_line(str(highscores[n]))
		f2.store_line(str(names[n]))
	f1.close()
	f2.close()

func check_new_score():
	for n in 10:
		if newScore > highscores[n]:
			newHighScore = n
			highscores.pop_back()
			highscores.insert(newHighScore, newScore)
			#make names match up with scores
			names.pop_back()
			$Popup.show()
			newHighScoreCheck = true
			break
	if(newHighScoreCheck == false):
		update_scores()

func update_scores():
	$Leaderbox/HBox1/VBox1/Player1.set_text(names[0] + ": " + str(highscores[0]))
	$Leaderbox/HBox1/VBox1/Player2.set_text(names[1] + ": " + str(highscores[1]))
	$Leaderbox/HBox1/VBox1/Player3.set_text(names[2] + ": " + str(highscores[2]))
	$Leaderbox/HBox1/VBox1/Player4.set_text(names[3] + ": " + str(highscores[3]))
	$Leaderbox/HBox1/VBox1/Player5.set_text(names[4] + ": " + str(highscores[4]))
	$Leaderbox/HBox2/VBox2/Player6.set_text(names[5] + ": " + str(highscores[5]))
	$Leaderbox/HBox2/VBox2/Player7.set_text(names[6] + ": " + str(highscores[6]))
	$Leaderbox/HBox2/VBox2/Player8.set_text(names[7] + ": " + str(highscores[7]))
	$Leaderbox/HBox2/VBox2/Player9.set_text(names[8] + ": " + str(highscores[8]))
	$Leaderbox/HBox2/VBox2/Player10.set_text(names[9] + ": " + str(highscores[9]))
	save_scores()


func _on_Button_pressed():
	var newName = $Popup/Initials.get_text()
	if(newName.length() <=3 && newName.length() > 0 ):
		names.insert(newHighScore, newName)
		$Popup.hide()
		update_scores()
		newHighScoreCheck = false
	else:
		$Popup/Error.show()
