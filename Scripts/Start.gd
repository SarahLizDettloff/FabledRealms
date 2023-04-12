extends CanvasLayer

func _ready():
	if get_tree().paused:
		get_tree().paused = false
		
func change_menu_color():
	$Start.color = Color.gray

func _input(event):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene("res://Scenes/Intro.tscn")

func _on_Start_pressed():
	get_tree().change_scene("res://Scenes/Intro.tscn")
