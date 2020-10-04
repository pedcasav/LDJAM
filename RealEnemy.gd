extends KinematicBody2D


export var Velocidad : = 50.0
export var Distancia = 170
onready var nav_2d : Navigation2D = $"../Navigation2D"
onready var interruptores = get_tree().get_nodes_in_group("interruptores")
var path : = PoolVector2Array()
var currentInterruptor = null
var rng = RandomNumberGenerator.new()

func _ready():
	SelectInrretupor()

func SelectInrretupor():
	rng.randomize()
	var indice = rng.randi_range(0,len(interruptores) - 1)
	var tmpcurrentInterruptor = interruptores[indice]
	while(tmpcurrentInterruptor == currentInterruptor):
		rng.randomize()
		indice = rng.randi_range(0,len(interruptores) - 1)
		tmpcurrentInterruptor = interruptores[indice]
	currentInterruptor = tmpcurrentInterruptor
func moveToPath(posA, posB,distance):
	path = nav_2d.get_simple_path(posA,posB,false)
	
	if(path.size() == 0):
		pass
	var start_point := position
	for i in range(path.size()):
		var distance_to_next := start_point.distance_to(path[0])
		if(distance <= distance_to_next and distance >= 0.0):
			position = start_point.linear_interpolate(path[0],distance / distance_to_next)
			#move_and_slide(Vector2(0,0))
			break
		elif distance < 0.0:
			position = path[0]
			break
		distance -= distance_to_next
		start_point = path[0]
		path.remove(0)

func _physics_process(delta : float):
	var posicionPlayer = $"../PlayerLight".position
	var distanciaActual = sqrt(pow(posicionPlayer.x - position.x,2) + pow(posicionPlayer.y - position.y, 2))
	
	$"../LabelDistancia".set_text(str(get_global_mouse_position()))

	var distance : = Velocidad * delta
	if distanciaActual < Distancia:
		moveToPath(position,posicionPlayer,distance)
	else:
		moveToPath(position,currentInterruptor.position,distance)
		pass


func _on_Area2D_body_entered(body):
	if(body.name == 'PlayerLight'):
		get_tree().reload_current_scene()
