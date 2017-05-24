extends KinematicBody2D

var gelo
export(int, 1, 30) var vida = 1
var vivo = true
var intervalo = 1
var ultimo_toque = 0

func _ready():
	gelo = load("res://cenas/gelo.tscn")
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	
	pass

func criar_gelo():
	get_tree().get_root().add_child(gelo.instance())
	get_tree().get_root().add_child(gelo.instance())
	get_tree().get_root().add_child(gelo.instance())
	get_tree().get_root().add_child(gelo.instance())
	get_tree().get_root().add_child(gelo.instance())
	get_tree().get_root().add_child(gelo.instance())
	pass

func _on_Timer_timeout():
	get_node("ataque1").play("ataque01")
	pass # replace with function body


func _on_Area2D_body_enter( body ):
	get_tree().get_root().get_node("main/player").dano(1)
	pass # replace with function body
	
func dano(qtde):
	
	
	queue_free()
	
	pass
