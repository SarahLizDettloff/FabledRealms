extends Area2D

var active = false
var time_start = 0
var time_now = 0
var time_elapsed = 0
var counter = 0
var dialog_name = ""
var popup_active = false
var destination = Vector2(0, 0)
var PeaSoupRecipeObtained = false

onready var PickupPeaSoupRecipe = get_node("../PickupPeaSoupRecipe/PeaSoupRecipe")
onready var PeaSoupRecipe = get_node("../UI/PeaSoupRecipe")
onready var player_vars = get_node("/root/Global")
onready var pickup_sound = get_node("../ItemGrabbed")

func _ready():
	
	connect("body_entered", self, "_on_PeaSoupRecipe_body_entered")
	connect("body_exited", self, "_on_PeaSoupRecipe_body_exited")

func _process(delta):
	if counter == 0 and not PeaSoupRecipeObtained and active:
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

func _input(event):
	if get_node_or_null("DialogNode") == null:
		if Input.is_action_pressed("attack") and active and not PeaSoupRecipeObtained:
			if counter == 0:
				pickup_sound.play()
				dialog_name = "pickupPeaSoupRecipe"
				get_tree().paused = true
				var dialog = Dialogic.start(dialog_name)
				dialog.pause_mode = Node.PAUSE_MODE_PROCESS
				dialog.connect("timeline_end", self, "unpaused")
				add_child(dialog)
				PickupPeaSoupRecipe.hide()
				active = false
				player_vars.inventory.append("PeaSoupRecipe")
				PeaSoupRecipeObtained = true
				PeaSoupRecipe.show()
				# pickup_sound.play()

func unpaused(timeline_name):
	get_tree().paused = false
	active = false
	if counter == 0:
		popup_active = true
		time_start = OS.get_unix_time()
	if counter == 1:
		popup_active = true
		time_start = OS.get_unix_time()
	counter += 1


func _on_PeaSoupRecipe_body_entered(body):
	if body.name == "Player":
		active = true

func _on_PeaSoupRecipe_body_exited(body):
	if body.name == "Player":
		active = false
