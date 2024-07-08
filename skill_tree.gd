extends Control


func _on_btn_close_pressed():
	queue_free()


func _on_btn_confirm_pressed():
	queue_free()

<<<<<<< Updated upstream
func _input(ev):
	if Input.is_key_pressed(KEY_ESCAPE):
		print("EscapeKeyPressed")
		get_node(".").set_scale(Vector2(0,0))
=======
func _process(delta):
	if Input.is_key_pressed(KEY_ESCAPE):
		queue_free()
>>>>>>> Stashed changes
