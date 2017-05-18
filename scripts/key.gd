extends Area2D

func _ready():
	pass

func _on_key_body_enter( body ): 
	get_node("sample").play("key")
	get_tree().get_root().get_node("main/player").key = true
	get_node("sprite").free()
	get_node("shape").free()
	pass # replace with function body
