extends Area2D


export var speed : int = 100
export var moveDist : int = 100

var startX = 0
var targetX = 0


func _physics_process(delta):
	position.x += 5
	yield(get_tree().create_timer(.8), "timeout")

	position.x -= 5

# moves "current" towards "to" at a rate of "step"
func move_to(current, to, step):
	var new = current

	# are we moving positive?
	if new < to:
		new += step 
		if new > to:
			new = to
