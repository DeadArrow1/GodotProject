extends Control

func _ready():
	Global.pauseGame(true)

func _on_btn_close_pressed():
	Global.pauseGame(false)
	queue_free()


func _on_btn_confirm_pressed():
	Global.pauseGame(false)
	queue_free()
