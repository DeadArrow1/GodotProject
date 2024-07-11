extends Control

	
func _ready():
	Global.isSkillTreeOpen=false
	Global.enemiesCount=-1
	
	$CenterContainer/VBoxContainer/StartButton.pressed.connect(self.start_button_pressed)
	$CenterContainer/VBoxContainer/QuitGameButton.pressed.connect(self.quit_button_pressed)
	
func start_button_pressed():
	Global.pauseGame(false)
	
	
	Global.InitializeSkills()
	Global.maxHealth=Global.maxHealthBase
	Global.health = Global.healthBase
	Global.XP=Global.XPBase
	Global.XPlevelUP=Global.XPlevelUPBase
	Global.armor=Global.armorBase
	Global.level=Global.levelBase
	Global.attack=Global.attackBase
	Global.skillPointCount=Global.skillPointCountBase
	Global.movementSpeed=Global.movementSpeedBase
	
	
	
	Global.goto_scene("res://level_1.tscn")

func quit_button_pressed():
	get_tree().quit()
