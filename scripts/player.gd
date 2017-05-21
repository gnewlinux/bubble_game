extends KinematicBody2D

# Member variables
const GRAVITY = 500.0 # Pixels/second

# Angle in degrees towards either side that the player can consider "floor"
const FLOOR_ANGLE_TOLERANCE = 40
const WALK_FORCE = 600
const WALK_MIN_SPEED = 10
const WALK_MAX_SPEED = 100
const STOP_FORCE = 1300
const JUMP_SPEED = 230
const JUMP_MAX_AIRBORNE_TIME = 0.2

const SLIDE_STOP_VELOCITY = 1.0 # One pixel per second
const SLIDE_STOP_MIN_TRAVEL = 1.0 # One pixel

var velocity = Vector2()
var on_air_time = 100
var jumping = false

var prev_jump_pressed = false

### VARIAVEIS ADICIONAIS
var estava_chao = "false"
var nova_anim = ""
var animacao = ""
var life = 3
var contador = 0.1
var contador_morte = 1
var shape = 0
var key = false
var time = false


func _fixed_process(delta):
	if life <= 0:
		contador_morte += contador_morte * delta
		if contador_morte >= 1:
			get_tree().reload_current_scene()
			time = false
	
	if time == true:
		contador += contador * delta
		get_node("direita").set_collision_mask(0)
		if contador >= 0.5:
			get_node("direita").set_collision_mask(4)
			print("virou")
			contador = 0.1
			time = false
		
	# Create forces
	var force = Vector2(0, GRAVITY)
	
	var walk_left = Input.is_action_pressed("move_left")
	var walk_right = Input.is_action_pressed("move_right")
	var jump = Input.is_action_pressed("jump")
	
	var stop = true
	if key == true:
		get_tree().get_root().get_node("main/key_top/key").set_opacity(1)

	if (walk_left):
		get_node("particles").vira(200)
		get_node("particles").posicao(8)
		if (velocity.x <= WALK_MIN_SPEED and velocity.x > -WALK_MAX_SPEED):
			force.x -= WALK_FORCE
			stop = false
	elif (walk_right):
		get_node("particles").vira(20)
		get_node("particles").posicao(-8)
		if (velocity.x >= -WALK_MIN_SPEED and velocity.x < WALK_MAX_SPEED):
			force.x += WALK_FORCE
			stop = false
	
	if (stop):
		var vsign = sign(velocity.x)
		var vlen = abs(velocity.x)
		
		vlen -= STOP_FORCE*delta
		if (vlen < 0):
			vlen = 0
		
		velocity.x = vlen*vsign
	
	# Integrate forces to velocity
	velocity += force*delta
	
	# Integrate velocity into motion and move
	var motion = velocity*delta
	
	# Move and consume motion
	motion = move(motion)
	
	var floor_velocity = Vector2()
	
	if (is_colliding()):
		# You can check which tile was collision against with this
		# print(get_collider_metadata())
		
		# Ran against something, is it the floor? Get normal
		var n = get_collision_normal()
		
		if (rad2deg(acos(n.dot(Vector2(0, -1)))) < FLOOR_ANGLE_TOLERANCE):
			# If angle to the "up" vectors is < angle tolerance
			# char is on floor
			on_air_time = 0
			floor_velocity = get_collider_velocity()
		
		if (on_air_time == 0 and force.x == 0 and get_travel().length() < SLIDE_STOP_MIN_TRAVEL and abs(velocity.x) < SLIDE_STOP_VELOCITY and get_collider_velocity() == Vector2()):
			# Since this formula will always slide the character around, 
			# a special case must be considered to to stop it from moving 
			# if standing on an inclined floor. Conditions are:
			# 1) Standing on floor (on_air_time == 0)
			# 2) Did not move more than one pixel (get_travel().length() < SLIDE_STOP_MIN_TRAVEL)
			# 3) Not moving horizontally (abs(velocity.x) < SLIDE_STOP_VELOCITY)
			# 4) Collider is not moving
			
			revert_motion()
			velocity.y = 0.0
		else:
			# For every other case of motion, our motion was interrupted.
			# Try to complete the motion by "sliding" by the normal
			motion = n.slide(motion)
			velocity = n.slide(velocity)
			# Then move again
			move(motion)
	
	if (floor_velocity != Vector2()):
		# If floor moves, move with floor
		move(floor_velocity*delta)
	
	if (jumping and velocity.y > 0):
		# If falling, no longer jumping
		jumping = false
	
	if (on_air_time < JUMP_MAX_AIRBORNE_TIME and jump and not prev_jump_pressed and not jumping):
		# Jump must also be allowed to happen if the character left the floor a little bit ago.
		# Makes controls more snappy.
		pula()
		get_node("particles").parar()
	
	on_air_time += delta
	prev_jump_pressed = jump
	
	#### TESTES DE COLISAO COM O CHAO
	var chao = get_node("rayChao").is_colliding()
	if chao && !estava_chao:
		get_node("animFX").play("caiu")
		pass

	estava_chao = chao
	
	#### TESTES SE ESTIVER ANDANDO
	var andando = walk_right || walk_left

	#### ANIMACOES PERSONAGEM
	if andando:
		#get_node("sample").play("step")
		if velocity.x > 0:
			get_node("sprite").set_flip_h(false)
		else:
			get_node("sprite").set_flip_h(true)
	#print(velocity.y)
	if velocity.y == 0: # ta no chao
		if andando:
			nova_anim = "walking"
		else:
			nova_anim = "stopped"
	elif velocity.y < 0: # ta pulando
		nova_anim = "jumping"
		get_node("particles").set_hidden(true)
	else: # velocity.y maior que 0
		nova_anim = "falling"
		get_node("particles").set_hidden(true)
	
	if animacao != nova_anim:
		get_node("anim").play(nova_anim)
		animacao = nova_anim
		#print(nova_anim)
		pass

func _ready():
	set_fixed_process(true)
	pass
	
func pula(): 
	get_node("animFX").play("pulou")
	velocity.y = -JUMP_SPEED
	jumping = true
	pass

func pula_dano():
	get_node("animFX").play("pulou")
	velocity.y = -120
	jumping = true
	pass

func pula_morcego():
	get_node("animFX").play("pulou")
	velocity.y = -500
	jumping = true
	pass
	
var segundos = 1
var total = 1

func dano(dan):
	time = true
	life -= dan
	get_tree().get_root().get_node("main/anime_player").play("anime_player")
	pula_dano()
	pass
	
func die():
	get_tree().reload_current_scene()
	pass

func _on_Area2D_body_enter( body ):
	get_tree().change_scene("res://cenas/finish.tscn")
	pass # replace with function body


func _on_kill_body_enter( body ):
	print("morreu")
	get_tree().reload_current_scene()
	pass # replace with function body


func _on_pes_body_enter( body ):
	body.dano(1)
	pula()
	pass # replace with function body


func _on_direita_body_enter( body ):
	dano(1)
	pula_dano()
	pass # replace with function body