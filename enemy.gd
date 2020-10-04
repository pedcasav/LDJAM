extends Sprite

export var Velocidad : = 50.0
export var Distancia = 170
onready var nav_2d : Navigation2D = $"../Navigation2D"
var path : = PoolVector2Array()

func _ready():
	var posicionPlayer = $"../PlayerLight".position
	

func _physics_process(delta : float):
	var posicionPlayer = $"../PlayerLight".position
	var distanciaActual = sqrt(pow(posicionPlayer.x - position.x,2) + pow(posicionPlayer.y - position.y, 2))

	if distanciaActual < Distancia:
		path = nav_2d.get_simple_path(position,posicionPlayer)
	
		var distance : = Velocidad * delta
		#$"../LabelDistancia".set_text(str(position))
		$"../LabelDistancia".set_text(str(get_global_mouse_position()))
		if(path.size() == 0):
			pass
		var start_point := position
		for i in range(path.size()):
			var distance_to_next := start_point.distance_to(path[0])
			if(distance <= distance_to_next and distance >= 0.0):
				position = start_point.linear_interpolate(path[0],distance / distance_to_next)
				break
			elif distance < 0.0:
				position = path[0]
				break
			distance -= distance_to_next
			start_point = path[0]
			path.remove(0)
	else:
		pass
		#$"../LabelDistancia".set_text("Out of Range")	

	
