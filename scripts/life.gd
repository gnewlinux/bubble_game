extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	set_process(true)
	pass

func _process(delta):
	if get_node("../../player").life == 3:
		get_node("anim").play("heart3")
	if get_node("../../player").life == 2:
		get_node("anim").play("heart2")
	if get_node("../../player").life == 1:
		get_node("anim").play("heart1")
	if get_node("../../player").life == 0:
		get_node("anim").play("heart")
	pass
