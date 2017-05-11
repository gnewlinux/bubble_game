extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_shooter_body_enter( body ):
	get_tree().get_root().get_node("main/player").dano()
	pass # replace with function body
