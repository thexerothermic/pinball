extends ProgressBar

func _ready():
	set_process(true)


func _process(delta):
	get_parent().get_node("LoadingGear").rect_rotation+=240*delta





var j1="Watching the grass grow..."
var j2="Loading coconut scripts..."
var j3="Deleting mac & cheese stains..."
var j4="Nerfing the weak units..."
var j5="Buffing the strong units..."
var j6="Loading effects..."
var j7="Loading mobs..."
var j8="Is this nonsense still loading?"
var jokes=[j1,j2,j3,j4,j5,j6,j7,j8]

var joke_switch:bool=true

func update_bar(val):
	Animator.linear_animate(self,"value",val,0.2)
	get_parent().get_node("ProgressLabel").text=str(int(val))+"%"

#Should we do it? lmao
#	if(joke_switch):
#		get_parent().get_node("Joke").text=str(HelperFunctions.pick_one(jokes))
#	joke_switch=!joke_switch

