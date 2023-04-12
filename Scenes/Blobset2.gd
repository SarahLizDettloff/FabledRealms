extends KinematicBody2D
#
#var velocity = Vector2(0,0)
#const WALK_SPEED = 200
#const UP = Vector2(0, -1)
#const GRAVITY = 20
#const SPEED = 15
#
#var motion = Vector2()
#var left = Vector2(-1, 0)
#var right = Vector2(1, 0)
#var direction = left
#var attacking = false
#onready var player = get_node("../Player")
#var damage_taken = false
#var hit_counter = 0
#var active = false
#var player_hit_counter = 0
#var enemey_defeated = false
#var last_position
#var move = left
#var player_direction = null
#var timer_start = false
#var timer = 0
#var wait_time = 2
##onready var enemy_dying_sound = get_node("../EnemyDying")
#
#
#func _ready():
#	last_position = global_position
#
#func _process(delta):
#	var animation = get_animation_for(last_position - global_position)
#	last_position = global_position
#
#func _physics_process(delta):
#
#	motion.y += GRAVITY
#	player_direction = player.direction
#	if player_direction == "left":
#		motion.x = -100
#		direction = right
#	if player_direction == "right":
#		motion.x = 100
#		direction = left
#
#
#	#print(direction)
#	motion.x = direction.x * SPEED
#	motion = move_and_slide(motion, UP)
#
#	motion += position.direction_to(player.position)
#	if is_on_wall():
#		if direction == left:
#			direction = right
#		elif direction == right:
#			direction = left
#
#	for i in get_slide_count():
#		var collision = get_slide_collision(i)
#		if (collision.collider.name == "Player"):
#			if player.attack_playing or player.is_attacking:
#				hit_counter += 1
#				if hit_counter >= 1:
#					var enemey_defeat_location = $Blobset2AnimatedSprite.position
#					blobset_bye()
#				if player_hit_counter >= 1:
#					player.die()
#			else:
#				player_hit_counter += 1
#				if player_hit_counter >= 1:
#					player.die()
#
#
#func blobset_bye():
#	#enemy_dying_sound.play()
#	get_node("CollisionShape2D").disabled = true
#	#get_node("Blobset1").play("dying")
#	enemey_defeated = true
#	player.is_attacking = false
#	timer_start = true
#	if timer > wait_time:
#		timer_start = false
#		timer = 0	
#	if not timer_start:
#		get_node("Blobset2AnimatedSprite").hide()
