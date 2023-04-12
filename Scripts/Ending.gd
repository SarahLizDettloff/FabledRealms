extends Node2D


var counter = 0
var dialog_name = ""
onready var player = get_node("You")

func _ready():
	if counter == 0:
		dialog_name = "timeline-ending"
		var dialog = Dialogic.start(dialog_name)
		dialog.pause_mode = Node.PAUSE_MODE_PROCESS
		dialog.connect("timeline_end", self, "unpaused")
		add_child(dialog)
			
func _input(event):
	if event.is_action_pressed("ui_accept"):
		print(counter)
		if counter == 0:
			player.play("Yay1")
		if counter == 1:
			player.play("default")
		if counter == 5:
			player.play("Yay1")
		if counter == 6:
			player.play("Yay2")
		if counter == 7:
			player.play("Yay3")
		if counter == 8:
			player.play("Yay2")
		if counter == 9:
			player.play("Yay3")
		if counter == 11:
			get_tree().change_scene("res://Scenes/Credits.tscn")
		counter += 1

