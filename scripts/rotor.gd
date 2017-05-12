extends Area2D

func _ready():
	pass
	

func _on_rotor_body_enter( body ):
	get_tree().get_root().get_node("main/player").dano(1)
	pass # replace with function body
