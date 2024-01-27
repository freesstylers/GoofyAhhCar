extends Control

@export var particle : Resource

var rng = RandomNumberGenerator.new()

func _input(event):
	if event.is_action_pressed("Accelerate"):
		var text = particle.instantiate()
		text.amount = rng.randi_range(0, 999)
		add_child(text)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
