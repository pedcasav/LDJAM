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
const SPEED = 150
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
	if Input.is_action_pressed("ui_right"):
			motion.x = 1
			_processDescanso()
	if Input.is_action_pressed("ui_left"):
		motion.x = -1
		_processDescanso()
	if Input.is_action_pressed("ui_down"):
		motion.y = 1
		_processDescanso()
	if Input.is_action_pressed("ui_up"):
		motion.y = -1
		_processDescanso()

		
	motion = move_and_slide(motion.normalized() * SPEED)
	
	if Input.is_action_just_pressed("ui_accept"):
		emit_signal("WHISTLE")

func _processDescanso():
	if cansancio > cansancioLimite:
		cansancio -= cansancioDescenso
		#$"../CansancioLabel".set_text(str(cansancio))
