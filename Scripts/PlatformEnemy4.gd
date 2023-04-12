extends Area2D


var speed = 1
var attacking = false
onready var player = get_node("../Player")
var damage_taken = false
var hit_counter = 0
var active = false
var player_hit_counter = 0
var enemey_defeated = false
var last_position
var player_direction = null
var timer_start = false
var timer = 0
var wait_time = 2
onready var enemy_dying_sound = get_node("../Hit")

export var enemy_name : String
export var distance_travel: int


func _ready():
	name = "_on_" + enemy_name + "_body_entered"
	connect("body_entered", self, name)


func _physics_process(_delta):
	position.x += speed

	if position.x >= 25:
		speed -= 1
	if position.x <= 0:
		speed += 1
		
				
func _on_Platform4_body_entered(body):
	if body.name == "Player" and not enemey_defeated:
		if player.attack_playing or player.is_attacking:
			hit_counter += 1
			if hit_counter >= 1:
				blobset_bye()
			if player_hit_counter >= 1:
				player.die()
		else:
			player_hit_counter += 1
			if player_hit_counter >= 1:
				player.die()

func blobset_bye():
	enemy_dying_sound.stream.loop = false
	enemy_dying_sound.play()
	enemey_defeated = true
	
	get_node("Platform4").hide()
