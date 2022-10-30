extends AnimatedSprite


func turn_on():
	self.play("on")
	$Light2D.set_enabled(true)
func turn_off():
	self.play("off")
	$Light2D.set_enabled(false)
