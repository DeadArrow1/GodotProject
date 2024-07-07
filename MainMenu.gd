extends Control

	
func _ready():
	$VBoxContainer/StartButton.pressed.connect(self.start_button_pressed)
	$VBoxContainer/QuitGameButton.pressed.connect(self.quit_button_pressed)
	
func start_button_pressed():
	Global.pauseGame(false)
	Global.maxHealth=100
	Global.health = 50
	Global.XP=0
	Global.XPlevelUP=100
	Global.armor=10
	Global.level=1
	Global.attack=30
	Global.skillPointCount=0
	Global.goto_scene("res://level_1.tscn")

func quit_button_pressed():
	get_tree().quit()
