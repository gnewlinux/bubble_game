extends Area2D

var segundos = 0
var encosta = false

func _ready():
	set_process(true)
	pass

func _process(delta):
	if encosta:
		segundos += 1 * delta

		#conta um segundo e dano!
		if segundos >= 1:
			get_node("../../player").dano()
			segundos = 0
			pass

	else:
		segundos = 0
		pass

func _on_Area2D_body_enter( body ):
	if !encosta:
		get_node("../../player").dano()
		encosta = true
	pass


func _on_poison_body_exit( body ):
	encosta = false
	pass # replace with function body
