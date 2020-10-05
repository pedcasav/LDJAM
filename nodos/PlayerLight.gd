extends KinematicBody2D

onready var IsInterruptor = $"../isInterruptor"
export var onInterruptor = false
onready var tiempo = $"../Timer"
onready var progreso = $"../CanvasLayer/BarraCansancio"

# Called when the node enters the scene tree for the first time.
func _ready():
	tiempo.set_wait_time(5)

func _process(delta):
	if (Input.is_action_pressed("Escape")):
		_backToMenu()

func _backToMenu():
	get_tree().change_scene("res://Menu.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
const SPEED = 120
var motion = Vector2()
var direction = 0
var asustado = false

#MOVIMIENTO DE PERSONAJE

#Valor en Porcentaje
var cansancio = 100
export var cansancioDescenso = 0.01
export var cansancioLimite = 40

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var anim = "normal"
	motion = Vector2()
	IsInterruptor.set_text(str(onInterruptor))
	motion.x = 0
	motion.y = 0
	
	# Movimiento del Jugador
	if tiempo.time_left <= 0:
		if Input.is_key_pressed(KEY_W):
			motion.y = -1
		if Input.is_key_pressed(KEY_S):
			motion.y = 1
		if Input.is_key_pressed(KEY_A):
			motion.x = -1
			direction = 0
		if Input.is_key_pressed(KEY_D):
			motion.x = 1
			direction = 1

		if asustado: 
			anim = "asustado"
		else: anim = "normal"

		if motion.x != 0 || motion.y != 0: 
			_processDescanso()
			if direction > 0:
				$AnimatedSprite.play("derecha_anim_" + anim)
			else:
				$AnimatedSprite.play("izquierda_anim_" + anim)
		else:
			if direction > 0:
				$AnimatedSprite.play("derecha_" + anim)
			else:
				$AnimatedSprite.play("izquierda_" + anim)
	
	#press to space when stay on interruptor
	#if(Input.is_action_just_pressed("ui_accept") && onInterruptor == true && tiempo.time_left <= 0):
	if(Input.is_action_just_pressed("mouse") && onInterruptor == true && tiempo.time_left <= 0):
		tiempo.start()
		progreso.value = 0
		progreso.visible = true
	
	if progreso.visible == true:
		progreso.value = 100 - (tiempo.time_left *100 / 5)
	motion = move_and_slide(motion.normalized() * SPEED)

func _processDescanso():
	if cansancio > cansancioLimite:
		cansancio -= cansancioDescenso
		#$"../CansancioLabel".set_text(str(cansancio))

func _on_Timer_timeout():
	var currentScene := get_tree().get_current_scene()
	var tmpArr = currentScene.interruptoresArreglados
	tmpArr[0] = true
	
	for v in range(tmpArr.size()):
		if(tmpArr[v] == false):
			tmpArr[v] = true
			break
	
	currentScene.interruptoresArreglados = tmpArr
	progreso.visible = false
	pass
