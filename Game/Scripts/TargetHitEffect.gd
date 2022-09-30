extends AnimatedSprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.play("default")
	QuickTimer.create_timer(self,"queue_free",[],1)
