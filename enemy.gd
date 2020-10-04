extends Sprite

export var Velocidad = 50
export var Distancia = 170

func _physics_process(delta):
	var posicionPlayer = $"../PlayerLight".position
	var distanciaActual = sqrt(pow(posicionPlayer.x - position.x,2) + pow(posicionPlayer.y - position.y, 2))
	#$"../LabelDistancia".set_text(str(position))
	$"../LabelDistancia".set_text(str(get_global_mouse_position()))
	if distanciaActual < Distancia:
		#$"../LabelDistancia".set_text("In Range")
		var astar = AStar2D.new()
		astar.add_point(1, posicionPlayer)
		astar.add_point(2, position)
		astar.connect_points(1,2,false)
		var nextstep = astar.get_closest_point(posicionPlayer)		
		var locacion = astar.get_point_position(nextstep)
		var x = locacion - position
		#print(str(x) + "|" + str(x.normalized()))
		
		position += x.normalized() * Velocidad * delta
	else:
		pass
		#$"../LabelDistancia".set_text("Out of Range")	

	
