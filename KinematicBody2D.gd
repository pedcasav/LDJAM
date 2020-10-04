extends KinematicBody2D

const SPEED = 150
var motion = Vector2()
var direction = 0

#Valor en Porcentaje
var cansancio = 100
export var cansancioDescenso = 0.01
export var cansancioLimite = 40

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	if Input.is_action_pressed("ui_right"):
			motion.x = SPEED * cansancio / 100
			motion.y = 0
			$Sprite.play("Derecha")
			direction = 3
			_processDescanso()
	elif Input.is_action_pressed("ui_left"):
		motion.x = -SPEED * cansancio / 100
		motion.y = 0
		$Sprite.play("Izquierda")
		direction = 1
		_processDescanso()
	elif Input.is_action_pressed("ui_down"):
		motion.y = SPEED * cansancio / 100
		motion.x = 0
		$Sprite.play("Abajo")
		direction = 0
		_processDescanso()
	elif Input.is_action_pressed("ui_up"):
		motion.y = -SPEED * cansancio / 100
		motion.x = 0
		$Sprite.play("Arriba")
		direction = 2
		_processDescanso()
	else:
		motion.x = 0
		motion.y = 0
		match direction:
			0:
				$Sprite.play("AbajoI")
			1:
				$Sprite.play("IzquierdaI")
			2:
				$Sprite.play("ArribaI")
			3:
				$Sprite.play("DerechaI")
		
	motion = move_and_slide(motion)

func _processDescanso():
	if cansancio > cansancioLimite:
		cansancio -= cansancioDescenso
		$"../CansancioLabel".set_text(str(cansancio))
	
	
func _process(delta):
	
	if (Input.is_action_pressed("Escape")):
		_backToMenu()
	

func _backToMenu():
	
	get_tree().change_scene("res://Menu.tscn")


