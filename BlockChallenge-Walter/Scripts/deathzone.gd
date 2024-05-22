extends Area2D



func _on_body_entered(body):
	if body.get_name()=="robot":
		die()

func die():
	# Por ejemplo, podrías reiniciar la escena
	get_tree().reload_current_scene()
