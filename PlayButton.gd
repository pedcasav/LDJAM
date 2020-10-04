extends TextureButton
#dictionary
var scenes = {
	"PlayButton": preload("res://lightingtest.tscn"),
<<<<<<< HEAD
=======
	"LightingButton" : preload("res://lightingtest.tscn"),
>>>>>>> 0713cbc064c6d4b7c8c20d632823896de8dc5f6c
}

func _ready():
	$Label.text = "Play"

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _play():
	get_tree().change_scene_to(scenes[get_name()])


func _on_PlayButton_button_down():
	_play()
