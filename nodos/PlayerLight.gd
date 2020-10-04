extends KinematicBody2D

onready var IsInterruptor = $"../isInterruptor"
export var onInterruptor = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _process(delta):
	if (Input.is_action_pressed("Escape")):
		_backToMenu()

func _backToMenu():
	get_tree().change_scene("res://Menu.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
const SPEED = 120
var motion = Vector2()
var direction = 0

#MOVIMIENTO DE PERSONAJE

#Valor en Porcentaje
var cansancio = 100
export var cansancioDescenso = 0.01
export var cansancioLimite = 40

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	motion = Vector2()
	
	IsInterruptor.set_text(str(onInterruptor))
	
	# Movimiento del Jugador
	if Input.is_key_pressed(KEY_W):
		motion.y = -1
	if Input.is_key_pressed(KEY_S):
		motion.y = 1
	if Input.is_key_pressed(KEY_A):
		motion.x = -1
	if Input.is_key_pressed(KEY_D):
		motion.x = 1

	if motion.x != 0 || motion.y != 0: _processDescanso()
		
	motion = move_and_slide(motion.normalized() * SPEED)

func _processDescanso():
	if cansancio > cansancioLimite:
		cansancio -= cansancioDescenso
		#$"../CansancioLabel".set_text(str(cansancio))
