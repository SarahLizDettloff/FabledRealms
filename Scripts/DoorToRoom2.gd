extends Area2D

var active = false
var counter = 0
var time_start = 0
var time_now = 0
var time_elapsed = 0
var popup_active = false

func _ready():
	connect("body_entered", self, "_on_Door_body_entered")
	connect("body_exited", self, "_on_Door_body_exited")

func _process(_delta):
	if counter == 0 and active:
		$Arrow.visible = active
		time_now = OS.get_unix_time()
		time_elapsed = time_now - time_start
		if time_elapsed >= 3:
			if popup_active:
				if counter == 1:
					time_start = 0
				if counter == 2:
					
					time_start = 0
	else:
		$Arrow.visible = false
		
func _input(_event):
	if Input.is_action_pressed("attack") and active:
		get_tree().change_scene("res://Scenes/Room2.tscn")
				
func _on_Door_body_entered(body):
	if body.name == "Player":
		active = true

func _on_Door_body_exited(body):
	if body.name == "Player":
		active = false
