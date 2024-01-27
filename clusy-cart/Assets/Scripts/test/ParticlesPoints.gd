extends Control

@export var particle : Resource

func _init():
	Globals.exp_gain.connect(pointReceive)
	pass

func pointReceive(exp : float, points: float):
	SpawnParticle(points)
	pass

func SpawnParticle(amount):
	var text : Label
	text = particle.instantiate()
	var t = text.get_global_transform()
	text.amount = amount
	add_child(text)
	pass
