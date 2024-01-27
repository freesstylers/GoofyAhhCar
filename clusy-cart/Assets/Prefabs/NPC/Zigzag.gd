class_name ZigZag
extends CollisionShape2D

@export var amplitude : float = 1
@export var frecuency : float = 1

var lapsed = 0
var realocate = false

func _process(delta):
	if realocate:
		return_origin(delta)
		return
	rotation = 0
	lapsed = lapsed + delta
	position.y = + position.y + amplitude*sin(lapsed*frecuency)

func return_origin(delta):
	var rot = -90
	if position.y < 0:
		rot = 90
	rotation = deg_to_rad(rot)
	var dir = -position
	position = position + dir*delta
