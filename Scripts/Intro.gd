extends Node2D


var counter = 0
var dialog_name = ""
onready var background = get_node("Background")
onready var you = get_node("You")


func _ready():
	if counter == 0:
			dialog_name = "timeline-Intro"
			var dialog = Dialogic.start(dialog_name)
			dialog.pause_mode = Node.PAUSE_MODE_PROCESS
			dialog.connect("timeline_end", self, "unpaused")
			add_child(dialog)
			
func _input(event):
	if event.is_action_pressed("ui_accept"):
		if counter == 1:
			background.play("2")
			you.play("Confused")
		if counter == 2:
			background.play("3")
			you.play("Shocked")
		if counter == 3:
			background.play("4")
			you.play("Sad")
		if counter == 4:
			background.play("5")
		if counter == 5:
			background.play("6")
			you.play("Confused")
		if counter == 6:
			background.play("7")
			you.play("Confused")
		if counter == 7:
			background.play("8")
			you.play("default")
		if counter == 8:
			background.play("9")
			you.play("Confused")
		if counter == 9:
			background.play("10")
			you.play("Hopeful")
		if counter == 12:
			get_tree().change_scene("res://Scenes/Room1.tscn")
		counter += 1

