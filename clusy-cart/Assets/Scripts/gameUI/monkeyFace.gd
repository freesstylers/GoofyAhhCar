extends AnimatedSprite2D

var faces : Array[String] = ["default", "laugh", "angry", "pog"]

func _ready():	
	Globals.change_face.connect(_on_monkeyfacechange)
	
func _on_monkeyfacechange(num:int):
	if num == 1:
		set_animation(faces[num]+str(randi()%3+1))
	elif num == 2:
		set_animation(faces[num]+str(randi()%2+1))
	else:
		set_animation(faces[num])
