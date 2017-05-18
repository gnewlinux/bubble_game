extends Area2D

func _ready():
	pass

func _on_heart_body_enter( body ):
	get_tree().get_root().get_node("main/player").life
	if get_tree().get_root().get_node("main/player").life <= 2:
		get_tree().get_root().get_node("main/player").life += 1
		get_node("sample").play("heart")
		get_node("life").free()
		get_node("CollisionShape2D").free()
	else:
		get_node("sample").play("heart")
		get_node("life").free()
		get_node("CollisionShape2D").free()
	pass