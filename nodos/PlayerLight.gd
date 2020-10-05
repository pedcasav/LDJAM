extends KinematicBody2D

onready var IsInterruptor = $"../isInterruptor"


export var onInterruptor = false
var InterruptorActual = {}
onready var tiempo = $"../Timer"
onready var progreso = $"../CanvasLayer/BarraCansancio"
onready var barraCansancio = $"../CanvasLayer/AnimatedSprite"

# Called when the node enters the scene tree for the first time.
func _ready():
	tiempo.set_wait_time(5)

func _process(delta):
	if (Input.is_action_pressed("Escape")):
		_backToMenu()

func _backToMenu():
	Global.objetos["camara"] = false
	Global.objetos["papeles"] = false
	Global.objetos["destornillador"] = false
	Global.objetos["camara"] = false
	get_tree().change_scene("res://Menu.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
export var SPEED = 120
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
	var teclaPresionada = false
	motion = Vector2()
	IsInterruptor.set_text(str(onInterruptor))
	motion.x = 0
	motion.y = 0
	if progreso.visible: asustado = true
	
	# Movimiento del Jugador
	if tiempo.time_left <= 0:
		if Input.is_key_pressed(KEY_W):
			motion.y = -1
			teclaPresionada = true
		if Input.is_key_pressed(KEY_S):
			motion.y = 1
			teclaPresionada = true
		if Input.is_key_pressed(KEY_A):
			motion.x = -1
			direction = 0
			teclaPresionada = true
		if Input.is_key_pressed(KEY_D):
			motion.x = 1
			direction = 1
			teclaPresionada = true

		if teclaPresionada: _processDescanso()
		
	if asustado: 
		anim = "asustado"
	else: anim = "normal"
		
	if teclaPresionada: 
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
	if(Input.is_action_just_pressed("mouse")):
		if isTriggerEnemy():
			# Ganar el Juego
			if Global.objetos["camara"]:
				Global.objetos["camara"] = false
				Global.objetos["papeles"] = false
				Global.objetos["destornillador"] = false
				Global.objetos["llave"] = false
				get_tree().change_scene("res://Win.tscn")
			else:
				print("no lleva camara")
		if onInterruptor && tiempo.time_left <= 0 && !InterruptorActual.isOn:
			tiempo.start()
			progreso.value = 0
			progreso.visible = true
	
	if progreso.visible:
		progreso.value = 100 - (tiempo.time_left * 100 / 5)
		
	motion = move_and_slide(motion.normalized() * (SPEED * cansancio / 100.0))
	
	# Barra de Cansancio
	barraCansancio.play("barra" + str(int(cansancio/10)-2))
	
	# Barra de Objetos
	$"../CanvasLayer/papeles".visible = Global.objetos["papeles"]
	$"../CanvasLayer/llave".visible = Global.objetos["llave"]
	$"../CanvasLayer/destornillador".visible = Global.objetos["destornillador"]
	$"../CanvasLayer/camara".visible = Global.objetos["camara"]

func isTriggerEnemy():
	var enemyPos = Vector2($"../RealEnemy".position.x-15,$"../RealEnemy".position.y-10)
	var enemySize = Vector2(64,64)
	return get_tree().get_current_scene().isTriggerBox(enemyPos,enemySize)

func _processDescanso():
	if cansancio > cansancioLimite:
		cansancio -= cansancioDescenso
		#$"../CansancioLabel".set_text(str(cansancio))

func _on_Timer_timeout():
	var currentScene := get_tree().get_current_scene()
	var tmpArr = currentScene.interruptoresArreglados
	#tmpArr[0] = true
	if !InterruptorActual.isOn:
		InterruptorActual.isOn = true
		$"../soundBeep".play()
	
#	for v in range(tmpArr.size()):
#		if(tmpArr[v] == false):
#			tmpArr[v] = true
#			break
	
	currentScene.interruptoresArreglados = tmpArr
	progreso.visible = false
	pass
