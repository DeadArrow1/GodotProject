extends Control


func _on_start_button_pressed():
	Global.maxHealth=100
	Global.health = 50
	Global.XP=0
	Global.XPlevelUP=100
	Global.armor=10
	Global.level=1
	Global.attack=30
	Global.skillPointCount=0
	Global.goto_scene("res://level_1.tscn")
