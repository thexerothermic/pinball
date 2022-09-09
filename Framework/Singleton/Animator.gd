#Animate.gd
#---------------------
#Offers quick animaton functions using tweens. Can animate most object attributes
#---------------------

extends Node


var tween_res=preload("res://Framework/Singleton Dependencies/Tween.tscn")


func linear_animate(target_object,target_property,ending_value,duration,ease_type = Tween.EASE_IN):
	#Animates the target object's property with a simple linear tween using current values
	if(!weakref(target_object).get_ref()): return # Don't animate on objects that don't exist!
	
	var basic_tween=tween_res.instance()
	var starting_value=target_object.get(target_property)
	basic_tween.connect("tween_completed",self,"dump_tween",[basic_tween])
	basic_tween.interpolate_property(target_object,target_property,starting_value,ending_value,duration,0,ease_type,0)
	add_child(basic_tween)
	basic_tween.start()


func quad_animate(target_object,target_property,ending_value,duration,ease_type = Tween.EASE_IN):
	#Animates the target object's property with a simple linear tween using current values
	if(!weakref(target_object).get_ref()): return # Don't animate on objects that don't exist!
	
	var basic_tween=tween_res.instance()
	var starting_value=target_object.get(target_property)
	basic_tween.connect("tween_completed",self,"dump_tween",[basic_tween])
	basic_tween.interpolate_property(target_object,target_property,starting_value,ending_value,duration,Tween.TRANS_QUAD,ease_type,0)
	add_child(basic_tween)
	basic_tween.start()


func elastic_animate(target_object,target_property,ending_value,duration):
	#Animates the target object's property with a simple elastic tween using current values
	if(!weakref(target_object).get_ref()): return # Don't animate on objects that don't exist!
	
	var basic_tween=tween_res.instance()
	var starting_value=target_object.get(target_property)
	basic_tween.connect("tween_completed",self,"dump_tween",[basic_tween])
	basic_tween.interpolate_property(target_object,target_property,starting_value,ending_value,duration,Tween.TRANS_ELASTIC,Tween.EASE_OUT,0)
	add_child(basic_tween)
	basic_tween.start()


func elastic_animate_in(target_object,target_property,ending_value,duration):
	#Animates the target object's property with a simple elastic tween using current values
	if(!weakref(target_object).get_ref()): return # Don't animate on objects that don't exist!
	
	var basic_tween=tween_res.instance()
	var starting_value=target_object.get(target_property)
	basic_tween.connect("tween_completed",basic_tween,"dump_tween",[basic_tween])
	basic_tween.interpolate_property(target_object,target_property,starting_value,ending_value,duration,Tween.TRANS_ELASTIC,Tween.EASE_IN,0)
	add_child(basic_tween)
	basic_tween.start()

func dump_tween(_a,_b,tween_obj):
	#Deletes used tweens from the system, triggered by tweens created by the system via signaling
	tween_obj.queue_free()
