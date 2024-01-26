extends Node2D

class_name PointsB

@export var points : Array = []

var actualPoint : int = 0

func get_actual_point():
	return points[actualPoint]

func get_next_point():
	actualPoint = (actualPoint + 1) % points.size()
	return get_actual_point() 
