extends Area2D


# Declare member variables here. Examples:
# var a = 2
onready var guiapanel = $"../CanvasLayer/guia"
export(String, MULTILINE) var text = ''

var isJugador = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_pressed("mouse")):
		if get_tree().get_current_scene().isTriggerBox(position,Vector2(48,48)):
			$"../soundPickUp".play()
			Global.objetos["llave"] = true
			guiapanel.visible = true
			guiapanel.get_node("RichTextLabel").text = text
			get_tree().paused = true
	if(guiapanel.visible && Input.is_action_just_pressed("ui_accept")):
		guiapanel.visible = false
		guiapanel.get_node("RichTextLabel").text = ''
		get_tree().paused = false
	pass
