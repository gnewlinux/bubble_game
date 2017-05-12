extends Area2D

var segundos = 0

func _ready():
	set_process(true)
	pass
	
func _process(delta):
	var rot = get_node("sprite").get_rot()
	segundos += 1
	print(segundos)
	get_node("sprite").set_rot(segundos)
	get_node("sprite").edit_set_pivot(Vector2(0,50))
	pass
