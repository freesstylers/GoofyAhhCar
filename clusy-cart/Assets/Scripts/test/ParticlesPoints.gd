extends Control

@export var particle : Resource

var rng = RandomNumberGenerator.new()

func _input(event):
	#TEST
	if event.is_action_pressed("Accelerate"):
		SpawnParticle(rng.randi_range(0, 999))
	pass

func SpawnParticle(amount):
	var text = particle.instantiate()
	text.amount = amount
	add_child(text)
	pass
