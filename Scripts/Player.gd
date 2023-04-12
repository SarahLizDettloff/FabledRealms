extends KinematicBody2D

# Movement
var velocity = Vector2(0,0)
var run_speed = 200
var jump_speed = -250
var gravity = 450

# Death
var is_dead = false
var already_paused

# Attack stuff
var attack_cooldown_time = 0
var next_attack_time = 0
var attack_damage = 30
var is_attacking = false
var direction = "right"
var attack_playing = false
onready var player_vars = get_node("/root/Global")
onready var alive = get_node("../UI/Heart")
onready var dying = get_node("../UI/Dying")
onready var dying_sound = get_node("../Hit")
onready var BdayCard = get_node("../UI/BdayCard")
onready var PeaSoupRecipe = get_node("../UI/PeaSoupRecipe")
onready var CatCollar = get_node("../UI/CatCollar")

var context = ""
var animating_left_or_right = false
var is_using_phone = false

func _ready():
	context = get_tree().get_current_scene().get_name()
	if "BirthdayCard" in player_vars.inventory:
		BdayCard.show()
	if "PeaSoupRecipe" in player_vars.inventory:
		PeaSoupRecipe.show()
	if "CatCollar" in player_vars.inventory:
		CatCollar.show()
		

func drop():
	position.y += 1
	
func get_input():
	velocity.x = 0
	var right = Input.is_action_pressed('ui_right')
	var left = Input.is_action_pressed('ui_left')
	var jump = Input.is_action_just_pressed('jump')
	

	if is_on_floor() and jump:
		if not left: # Right or default
			get_node("PlayerAnimatedSprite").play("Jump")
			$PlayerAnimatedSprite.flip_h = true
		if left:
			get_node("PlayerAnimatedSprite").play("Jump")
			$PlayerAnimatedSprite.flip_h = false
		
#		if not jumping_sound.playing:
#			jumping_sound.play()
		velocity.y = jump_speed
	if right:
		velocity.x += run_speed
	if left:
		velocity.x -= run_speed
	#if is_on_floor() and not jump:

#		jumping_sound.stop()


func _physics_process(delta):
	is_attacking = attack_playing
	if Input.is_action_pressed("attack"):
		var now = OS.get_ticks_msec()
		attack_playing = true
		if now >= next_attack_time:
			# Play attack animation
		
			# Add cooldown time to current time
			next_attack_time = now + attack_cooldown_time
		else:
			attack_playing = false
	else:
		attack_playing = false
				
	velocity.y += gravity * delta
	get_input()
	velocity = move_and_slide(velocity, Vector2(0, -1))
	var axisX = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if axisX == 0 and not is_dead and not attack_playing:
		get_node("PlayerAnimatedSprite").play("Idle")
		attack_playing = false
	if axisX == 0 and not is_dead and attack_playing:
		get_node("PlayerAnimatedSprite").play("AttackIdle")
	if Input.is_action_pressed("jump") or not is_on_floor():
		get_node("PlayerAnimatedSprite").play("Jump")
	if Input.is_action_pressed("right"):
		direction = "right"
		if attack_playing:
			if attack_playing:
				get_node("PlayerAnimatedSprite").play("AttackSide")
				$PlayerAnimatedSprite.flip_h = false
		else:
			get_node("PlayerAnimatedSprite").play("Run")
			$PlayerAnimatedSprite.flip_h = false
		
		if not Input.is_action_pressed("attack"):
			attack_playing = false
	if Input.is_action_pressed("down"):
		drop()
		attack_playing = false
	if Input.is_action_pressed("left"):
		direction = "left"
		if attack_playing:
			if attack_playing:
				get_node("PlayerAnimatedSprite").play("AttackSide")
				$PlayerAnimatedSprite.flip_h = true
		else:
			get_node("PlayerAnimatedSprite").play("Run")
			$PlayerAnimatedSprite.flip_h = true
		
		if not Input.is_action_pressed("attack"):
			attack_playing = false

func die():
	dying_sound.stream.loop = false
	dying_sound.play()
	alive.hide()
	dying.show()
	is_dead = true
	get_node("PlayerAnimatedSprite").play("Dead")
	yield(get_tree().create_timer(1.0), "timeout")
	get_tree().change_scene("res://Scenes/GameOver.tscn")


