extends KinematicBody2D

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
	
	if Input.is_action_pressed("ui_right"):
			motion.x = SPEED * cansancio / 100
			motion.y = 0
			direction = 3
			_processDescanso()
	elif Input.is_action_pressed("ui_left"):
		motion.x = -SPEED * cansancio / 100
		motion.y = 0
		direction = 1
		_processDescanso()
	elif Input.is_action_pressed("ui_down"):
		motion.y = SPEED * cansancio / 100
		motion.x = 0
		direction = 0
		_processDescanso()
	elif Input.is_action_pressed("ui_up"):
		motion.y = -SPEED * cansancio / 100
		motion.x = 0
		direction = 2
		_processDescanso()
	else:
		motion.x = 0
		motion.y = 0

		
	motion = move_and_slide(motion)

func _processDescanso():
	if cansancio > cansancioLimite:
		cansancio -= cansancioDescenso
		#$"../CansancioLabel".set_text(str(cansancio))
