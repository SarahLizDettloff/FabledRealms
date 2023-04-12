extends KinematicBody2D

export var gravity:float = 100
var _velocity:Vector2 = Vector2.RIGHT * 100

const FLOOR_NORMAL:Vector2 = Vector2.UP

func _physics_process(delta:float) -> void:
	_velocity.y += gravity * delta
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y
	if is_on_wall() or (is_on_floor() and not $RayCast2D.is_colliding()):
		_velocity.x *= -1.0
		$RayCast2D.position.x *= -1.0


#	- Enemies to keep on platforms
#	- Add Enemies throughout Room 1
#	- Room 2 design
#	- Room 2 Boss
#	- Ending
