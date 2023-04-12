extends Popup

#onready var player = get_node("../../Player")
var already_paused
var retry_pressed = false
var quit_pressed = false



func _ready():
	print("ready working")
	if retry_pressed:
		get_tree().reload_current_scene() 
	if quit_pressed:
		get_tree().change_scene("res://Scenes/MainMenu.tscn")
#
func _input(event):
	if visible:
		if Input.is_action_just_pressed("ui_accept"):
			get_tree().reload_current_scene() 


func _on_Retry_pressed():
	retry_pressed = true
	print("hit here")
