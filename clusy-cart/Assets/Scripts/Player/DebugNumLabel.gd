extends Label

func _on_plusfriction_pressed():
	text = str(text.to_float() + 0.1)


func _on_minusfriction_pressed():
	text = str(text.to_float() - 0.1)
