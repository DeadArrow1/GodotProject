extends Control

func _process(delta):
	if Input.is_action_just_pressed("PauseGame"):
		Global.pauseGame(false)
		queue_free()



func _on_button_pressed():
	get_tree().quit()


func _on_btn_back_to_menu_pressed():
	Global.goto_scene("res://main_menu.tscn")
