extends KinematicBody2D

const SPEED = 150
var motion = Vector2()
var direction = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
			motion.x = SPEED
			motion.y = 0
			$Sprite.play("Derecha")
			direction = 3
	elif Input.is_action_pressed("ui_left"):
		motion.x = -SPEED
		motion.y = 0
		$Sprite.play("Izquierda")
		direction = 1
	elif Input.is_action_pressed("ui_down"):
		motion.y = SPEED
		motion.x = 0
		$Sprite.play("Abajo")
		direction = 0
	elif Input.is_action_pressed("ui_up"):
		motion.y = -SPEED
		motion.x = 0
		$Sprite.play("Arriba")
		direction = 2
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

func _process(delta):
	
	if (Input.is_action_pressed("Escape")):
		_backToMenu()
	

func _backToMenu():
	
	get_tree().change_scene("res://Menu.tscn")
