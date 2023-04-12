extends CanvasLayer

func _input(event):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene("res://Scenes/Room1.tscn")

func _on_Retry_pressed():
	get_tree().change_scene("res://Scenes/Room1.tscn")

func _on_Quit_pressed():
	get_tree().change_scene("res://Scenes/MainMenu.tscn")
