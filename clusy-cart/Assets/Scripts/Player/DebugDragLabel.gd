extends Label

func _on_plusdrag_pressed():
	text = str(text.to_float() + 0.001)


func _on_minusdrag_pressed():
	text = str(text.to_float() - 0.001)
