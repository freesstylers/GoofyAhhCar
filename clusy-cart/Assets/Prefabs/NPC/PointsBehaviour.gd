extends Node
class_name PointsB

@export var points : Array[Node] = []
var actualPoint : int = 0

func get_actual_point():
	get_children()
	return points[actualPoint]

func get_next_point():
	actualPoint = (actualPoint + 1) % points.size()
	return get_actual_point() 
