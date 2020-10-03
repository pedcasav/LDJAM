extends Button

var game = preload("res://World.tscn")

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _play():
	get_tree().change_scene_to(game)


func _on_PlayButton_button_down():
	_play()
