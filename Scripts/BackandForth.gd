extends PathFollow2D


var speed = 200
var direction = 1

func _process(delta):
  
  if unit_offset == 1.0:
	  direction = -1
  elif unit_offset == 0.0:
	  direction = 1
  
  offset += speed * delta * direction
