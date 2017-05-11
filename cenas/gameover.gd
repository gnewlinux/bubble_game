extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	set_process(true)
	pass
	
func _process(delta):
	if Input.is_action_pressed("enter"):
		get_tree().change_scene("res://cenas/main.tscn")
	
	pass
