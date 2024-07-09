extends Control

func _ready():
	var Skills = Global.ActiveSkills
	
	var numberOfSkills=Skills.size()
	#Skills[0]=1
	for skillNumber in numberOfSkills:
		if(Skills[skillNumber]==1):
			get_node("VBoxContainer/ScrollContainer/Control/Talent"+str(skillNumber)).button_pressed = true
		else:
			get_node("VBoxContainer/ScrollContainer/Control/Talent"+str(skillNumber)).button_pressed = false
	
		
	
	


func _on_btn_close_pressed():
	Global.pauseGame(false)
	queue_free()


func _on_btn_confirm_pressed():
	SaveSkillpoints()
	RecalculateStats()
	Global.pauseGame(false)
	queue_free()

func _process(delta):
	if Input.is_key_pressed(KEY_ESCAPE):
		queue_free()
		
func SaveSkillpoints():
	var Skills = Global.ActiveSkills
	
	var numberOfSkills=Skills.size()
	#Skills[0]=1
	for skillNumber in numberOfSkills:
		if(get_node("VBoxContainer/ScrollContainer/Control/Talent"+str(skillNumber)).button_pressed == true):
			Skills[skillNumber]=1
		else:
			Skills[skillNumber]=0
			
func RecalculateStats():
	RecalculateHP()
	RecalculateArmor()
	RecalculateDamage()
	RecalculateSpeed()
	
func RecalculateHP():
	var Skills = Global.ActiveSkills
	var playerMaxHP=Global.maxHealthBase
	var numberOfSkills=Skills.size()
	
	for skillNumber in numberOfSkills:
		if(Skills[skillNumber]==1):
			playerMaxHP=playerMaxHP+Global.skillEffects[skillNumber][0]
			
	var BunusPercentage=0
	for skillNumber in numberOfSkills:
		
		if(Skills[skillNumber]==1):
			BunusPercentage=BunusPercentage+Global.skillEffects[skillNumber][1]
			
	playerMaxHP=playerMaxHP + playerMaxHP * BunusPercentage *0.01
	Global.maxHealth=playerMaxHP
	Global._on_player_max_health_changed(playerMaxHP)

func RecalculateArmor():
	var Skills = Global.ActiveSkills
	var playerArmor=Global.armorBase
	var numberOfSkills=Skills.size()
	
	for skillNumber in numberOfSkills:
		if(Skills[skillNumber]==1):
			playerArmor=playerArmor+Global.skillEffects[skillNumber][2]
			
	var BunusPercentage=0
	for skillNumber in numberOfSkills:
		
		if(Skills[skillNumber]==1):
			BunusPercentage=BunusPercentage+Global.skillEffects[skillNumber][3]
			
	playerArmor=playerArmor + playerArmor * BunusPercentage *0.01
	Global.armor=playerArmor
	Global._on_player_armor_changed(playerArmor)
	
func RecalculateDamage():
	var Skills = Global.ActiveSkills
	var playerDamage=Global.attackBase
	var numberOfSkills=Skills.size()
	
	for skillNumber in numberOfSkills:
		if(Skills[skillNumber]==1):
			playerDamage=playerDamage+Global.skillEffects[skillNumber][4]
			
	var BunusPercentage=0
	for skillNumber in numberOfSkills:
		
		if(Skills[skillNumber]==1):
			BunusPercentage=BunusPercentage+Global.skillEffects[skillNumber][5]
			
	playerDamage=playerDamage + playerDamage * BunusPercentage *0.01
	Global.attack=playerDamage
	Global._on_player_attack_changed(playerDamage)
	
func RecalculateSpeed():
	var Skills = Global.ActiveSkills
	var playerSpeed=Global.movementSpeedBase
	var numberOfSkills=Skills.size()
	
	var BunusPercentage=0
	for skillNumber in numberOfSkills:
		
		if(Skills[skillNumber]==1):
			BunusPercentage=BunusPercentage+Global.skillEffects[skillNumber][6]
			
	playerSpeed=playerSpeed + playerSpeed * BunusPercentage *0.01
	Global.movementSpeed=playerSpeed
