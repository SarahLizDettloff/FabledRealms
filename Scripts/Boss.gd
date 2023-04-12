extends KinematicBody2D

var velocity = Vector2(0,0)
const WALK_SPEED = 200
const UP = Vector2(0, -1)
const GRAVITY = 20
const SPEED = 15

var motion = Vector2()
var left = Vector2(-1, 0)
var right = Vector2(1, 0)
var direction = left
var attacking = false
onready var player = get_node("../Player")
onready var door = get_node("../DoorToEnding")
var damage_taken = false
var hit_counter = 0
var active = false
var player_hit_counter = 0
var enemey_defeated = false
var last_position
var move = left
var player_direction = null
var timer_start = false
var timer = 0
var wait_time = 2
onready var enemy_dying_sound = get_node("../Hit")
var ouch = false



func _ready():
	last_position = global_position

func _process(_delta):
	var animation = get_animation_for(last_position - global_position)
	last_position = global_position
		
func _physics_process(delta):
	
	player_direction = player.direction
	if player_direction == "left":
		motion.x = -100
		direction = right
	if player_direction == "right":
		motion.x = 100
		direction = left

	motion.y += GRAVITY
	
	
	#print(direction)
	motion.x = direction.x * SPEED
	motion = move_and_slide(motion, UP)

	motion += position.direction_to(player.position)
	if is_on_wall():
		if direction == left:
			direction = right
		elif direction == right:
			direction = left
			
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if (collision.collider.name == "Player"):
			if not ouch and (player.attack_playing or player.is_attacking):
				hit_counter += 1
				blob_hit(delta)
				if hit_counter >= 15:
					blob_bye()
				if player_hit_counter >= 1:
					player.die()
			else:
				if not ouch:
					player_hit_counter += 1
					if player_hit_counter >= 1:
						player.die()

func blob_hit(_delta):
	enemy_dying_sound.stream.loop = false
	enemy_dying_sound.play()
	get_node("Boss").play("Ouch")
	ouch = true
	yield(get_tree().create_timer(2.0), "timeout")
	get_node("Boss").play("default")
	ouch = false
	motion.y += -400
	yield(get_tree().create_timer(0.5), "timeout")
	
func get_animation_for(direction: Vector2):
	if player.direction == "left":
		get_node( "Boss" ).set_flip_h(false)
	else:
		get_node( "Boss" ).set_flip_h(true)
			
func blob_bye():
	door.show()
	enemy_dying_sound.stream.loop = false
	enemy_dying_sound.play()
	get_node("CollisionShape2D").disabled = true
	enemey_defeated = true
	player.is_attacking = false
	timer_start = true
	if timer > wait_time:
		timer_start = false
		timer = 0	
	if not timer_start:
		get_node("Boss").hide()
