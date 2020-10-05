extends Node2D

var interruptoresArreglados = []
onready var jugador = $"PlayerLight"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	var tmp_interruptor = get_tree().get_nodes_in_group("interruptores")
	for i in tmp_interruptor:
		#interruptoresArreglados.push_back(false)
		interruptoresArreglados.push_back(i)
	pass

func checkInterruptoresListos():
	for v in interruptoresArreglados:
		if(v.isOn == false):
			return false
			break
	return true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(checkInterruptoresListos() == true):
		print("abre la puerta")
		get_node("PuertaDeSalida").visible= true
		get_node("destornillador").visible = true
		set_process(false)
	pass

func _on_PuertaDeSalida_body_entered(body):
	if checkInterruptoresListos():
		print("Nivel Reiniciado")
		jugador.position = Vector2(1165,192)
		var tmp_interruptor = get_tree().get_nodes_in_group("interruptores")
		for i in tmp_interruptor:
			#interruptoresArreglados.push_back(false)
			#interruptoresArreglados.push_back(i)
			i.isOn = false
			i.get_node("Sprite").texture = load("res://assets/interruptor.png")
		get_node("PuertaDeSalida").visible = false
		#get_tree().reload_current_scene()
	pass # Replace with function body.
	
func isTriggerBox(Pos,Size):
	var mousePos = get_local_mouse_position()
	if (mousePos.x >= Pos.x && mousePos.x <= Pos.x + Size.x):
		if (mousePos.y >= Pos.y && mousePos.y <= Pos.y + Size.y):
			return true
	return false
