extends KinematicBody2D

export(int, 1, 10) var vida = 1
var vivo = true
var virou = false
var posicaox
var posicaofim

func _fixed_process(delta):
	var posicao = get_pos().x
	if virou == false:
		move(Vector2(-0.5,0))
		if posicao <= posicaofim:
			get_node("anim2").play("virando2")
			virou = true
	else:
		move(Vector2(0.5,0))
		if posicao == posicaox:
			get_node("anim2").play("virando")
			virou = false
			

	pass

func _ready():
	posicaox = get_pos().x
	posicaofim = posicaox - 70
	get_node("anim2").play("virando")
	set_fixed_process(true)
	pass
	
func dano(qtde):
	if !vivo:
		return
	vida -= qtde
	print (vida)
	if vida <= 0:
		vivo = false
		get_node("shape").queue_free()
		#get_node("anima_andando").stop()
		#get_node("anim").play("morre")
		#yield(get_node("anim"), "finished")
		queue_free()
		
