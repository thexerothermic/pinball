#MainMenuButton.gd
#------------------------------------------
#The master node is the node that this button will report click events to.
#Main menu buttons assume you want to call a function in the master node to do something (like load in another menu or something)
#i.e. The "play game" button would reference the main menu function that loads in the game world
#------------------------------------------


extends Button
export var name_of_master_node="MainMenu"
var master_node:Node
export var function_name_on_click:String=""
func _ready():
	if(find_master_node()):
		self.connect("button_down",master_node,function_name_on_click)
		self.connect("button_down",self,"button_press")
	
func find_master_node():
	#Gets the master node, reports an error in debug log if it can't find it..
	var search_cap=10					#search cap, for finding errors
	master_node=get_parent()
	while(search_cap>0&&master_node.name!=name_of_master_node):
		master_node=master_node.get_parent()
		search_cap-=1
		if(search_cap==0):
			print("Error: A main menu button ("+str(self.name)+") cannot find it's master node to report click events to!")
			return false
		if(master_node.name==get_tree().root.name):
			print("Error: A main menu button ("+str(self.name)+") cannot find it's master node to report click events to!")
			return false
	return true


func button_press():
	SoundSystem.play_sound("GUI/button_press",".ogg")
