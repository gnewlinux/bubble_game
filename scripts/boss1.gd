extends KinematicBody2D

var gelo
var vida = 1
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
	print("tocou")	
	pass # replace with function body
	
func dano(qtde):
	queue_free()
	
	pass
	
func anime2():
	get_node("ataque1").play("ataque02")
func anime1():
	get_node("ataque1").play("ataque01")
func anime02():
	get_node("ataque2").play("ataque_gelo")
	get_node("../rotores_direito/anim2").play("rotor2")
	get_node("../rotores_esquerdo/anim2").play("rotor1")
	
func shake():
	get_node("../anima_camera").play("camera01")
	print("shake")