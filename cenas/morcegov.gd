extends KinematicBody2D

export(int, 1, 10) var vida = 1
var vivo = true
var virou = false
var posicaox
var posicaoy
var posicaofim
var morreu = false

func _fixed_process(delta):
	var posicao = get_pos().x
	if !morreu:
		if virou == false:
			move(Vector2(0.5,0))
			if posicao >= posicaofim:
				get_node("anim2").play("virando")
				virou = true
		else:
			move(Vector2(-0.5,0))
			if posicao == posicaox:
				get_node("anim2").play("virando2")
				virou = false
			

	pass

func _ready():
	posicaox = get_pos().x
	posicaoy = get_pos().y
	posicaofim = posicaox + 70
	get_node("anim2").play("virando")
	set_fixed_process(true)
	pass
	
func dano(qtde):
	if !vivo:
		return
	vida -= qtde
	if vida <= 0:
		vivo = false
		morreu = true
		get_node("anim").play("morrendo")
		yield(get_node("anim"), "finished")
		set_pos(Vector2(-999,0))
		get_node("anim").play("respaw")
		yield(get_node("anim"), "finished")
		
		

		
func respaw():
	set_pos(Vector2(posicaox,posicaoy))
	get_node("anim").play("voando")
	morreu = false
	vivo = true

