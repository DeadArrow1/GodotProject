extends Control


var availableSkillPoints

func _ready():
	availableSkillPoints=Global.skillPointCount
	var Skills = Global.ActiveSkills
	
	var numberOfSkills=Skills.size()
	
	if(availableSkillPoints<1):
			#start with all disabled
		for skillNumber in numberOfSkills:
			if(Skills[skillNumber]==0):
				get_node("VBoxContainer/ScrollContainer/Control/Talent"+str(skillNumber)).disabled = true
				get_node("VBoxContainer/ScrollContainer/Control/Talent"+str(skillNumber)).modulate = Color(0.271, 0.271, 0.271)
	else:
		CheckPrerequisities()
	
	$VBoxContainer/Control/ColorRect/Control2/ColorRect/HBoxContainer/lblFreePointsCount.text=str(availableSkillPoints)
	
	for skillNumber in numberOfSkills:
		get_node("VBoxContainer/ScrollContainer/Control/Talent"+str(skillNumber)).toggled.connect(self.AddSkillPointCount)
	
	
	
	for skillNumber in numberOfSkills:
		if(Skills[skillNumber]==1):
			get_node("VBoxContainer/ScrollContainer/Control/Talent"+str(skillNumber)).button_pressed = true
		else:
			get_node("VBoxContainer/ScrollContainer/Control/Talent"+str(skillNumber)).button_pressed = false
			
			
	

func _on_btn_close_pressed():
	Global.isSkillTreeOpen=false
	Global.pauseGame(false)
	queue_free()


func _on_btn_confirm_pressed():
	Global.isSkillTreeOpen=false
	SaveSkillpoints()
	Global.RecalculateStats()
	#Global.skillPointCount=availableSkillPoints
	Global.UnspentSkillpoints=availableSkillPoints
	Global.toggleSkillPointButton()
	
	
	Global.pauseGame(false)
	
	
	
	queue_free()

func _process(delta):
	if Input.is_key_pressed(KEY_ESCAPE):
		Global.pauseGame(false)
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
			
#func RecalculateStats():
	#RecalculateHP()
	#RecalculateArmor()
	#RecalculateDamage()
	#RecalculateSpeed()
	#
#func RecalculateHP():
	#var Skills = Global.ActiveSkills
	#var playerMaxHP=Global.maxHealthBase
	#var numberOfSkills=Skills.size()
	#
	#for skillNumber in numberOfSkills:
		#if(Skills[skillNumber]==1):
			#playerMaxHP=playerMaxHP+Global.skillEffects[skillNumber][0]
			#
	#var BunusPercentage=0
	#for skillNumber in numberOfSkills:
		#
		#if(Skills[skillNumber]==1):
			#BunusPercentage=BunusPercentage+Global.skillEffects[skillNumber][1]
			#
	#playerMaxHP=playerMaxHP + playerMaxHP * BunusPercentage *0.01
	#Global.maxHealth=playerMaxHP
	#Global._on_player_max_health_changed(playerMaxHP)
#
#func RecalculateArmor():
	#var Skills = Global.ActiveSkills
	#var playerArmor=Global.armorBase
	#var numberOfSkills=Skills.size()
	#
	#for skillNumber in numberOfSkills:
		#if(Skills[skillNumber]==1):
			#playerArmor=playerArmor+Global.skillEffects[skillNumber][2]
			#
	#var BunusPercentage=0
	#for skillNumber in numberOfSkills:
		#
		#if(Skills[skillNumber]==1):
			#BunusPercentage=BunusPercentage+Global.skillEffects[skillNumber][3]
			#
	#playerArmor=playerArmor + playerArmor * BunusPercentage *0.01
	#Global.armor=playerArmor
	#Global._on_player_armor_changed(playerArmor)
	#
#func RecalculateDamage():
	#var Skills = Global.ActiveSkills
	#var playerDamage=Global.attackBase
	#var numberOfSkills=Skills.size()
	#
	#for skillNumber in numberOfSkills:
		#if(Skills[skillNumber]==1):
			#playerDamage=playerDamage+Global.skillEffects[skillNumber][4]
			#
	#var BunusPercentage=0
	#for skillNumber in numberOfSkills:
		#
		#if(Skills[skillNumber]==1):
			#BunusPercentage=BunusPercentage+Global.skillEffects[skillNumber][5]
			#
	#playerDamage=playerDamage + playerDamage * BunusPercentage *0.01
	#Global.attack=playerDamage
	#Global._on_player_attack_changed(playerDamage)
	#
#func RecalculateSpeed():
	#var Skills = Global.ActiveSkills
	#var playerSpeed=Global.movementSpeedBase
	#var numberOfSkills=Skills.size()
	#
	#var BunusPercentage=0
	#for skillNumber in numberOfSkills:
		#
		#if(Skills[skillNumber]==1):
			#BunusPercentage=BunusPercentage+Global.skillEffects[skillNumber][6]
			#
	#playerSpeed=playerSpeed + playerSpeed * BunusPercentage *0.01
	#Global.movementSpeed=playerSpeed
	
func CheckPrerequisities():
	var Skills = Global.ActiveSkills
	var numberOfSkills=Skills.size()
	
	#start with all disabled
	for skillNumber in numberOfSkills:
		if(Skills[skillNumber]==0):
			get_node("VBoxContainer/ScrollContainer/Control/Talent"+str(skillNumber)).disabled = true
			get_node("VBoxContainer/ScrollContainer/Control/Talent"+str(skillNumber)).modulate = Color(0.271, 0.271, 0.271)
		else:
			var listHPNodes=[0,3,4,9,10,16,23,31,37,44,50,55,60,67]
			if(listHPNodes.has(skillNumber)):
				get_node("VBoxContainer/ScrollContainer/Control/Talent"+str(skillNumber)).disabled = true
				get_node("VBoxContainer/ScrollContainer/Control/Talent"+str(skillNumber)).modulate = Color(1, 1, 1)
				get_node("VBoxContainer/ScrollContainer/Control/Talent"+str(skillNumber)).texture_disabled = load("res://SkillTree/Buttons/hpRed.png")


			var listArmorNodes=[1,5,6,11,12,18,25,26,39,40,45,46,48,49,54,57,63,69]
			if(listArmorNodes.has(skillNumber)):
				get_node("VBoxContainer/ScrollContainer/Control/Talent"+str(skillNumber)).disabled = true
				get_node("VBoxContainer/ScrollContainer/Control/Talent"+str(skillNumber)).modulate = Color(1, 1, 1)
				get_node("VBoxContainer/ScrollContainer/Control/Talent"+str(skillNumber)).texture_disabled = load("res://SkillTree/Buttons/armourYellow.png")



			var listAttackNodes=[2,7,8,13,14,20,28,34,42,47,53,59,66,71]
			if(listAttackNodes.has(skillNumber)):
				get_node("VBoxContainer/ScrollContainer/Control/Talent"+str(skillNumber)).disabled = true
				get_node("VBoxContainer/ScrollContainer/Control/Talent"+str(skillNumber)).modulate = Color(1, 1, 1)
				get_node("VBoxContainer/ScrollContainer/Control/Talent"+str(skillNumber)).texture_disabled = load("res://SkillTree/Buttons/attackGreen.png")
			
			
			
			var listHPREGEN=[15,22,30,36]
			if(listHPREGEN.has(skillNumber)):
				get_node("VBoxContainer/ScrollContainer/Control/Talent"+str(skillNumber)).disabled = true
				get_node("VBoxContainer/ScrollContainer/Control/Talent"+str(skillNumber)).modulate = Color(1, 1, 1)
				get_node("VBoxContainer/ScrollContainer/Control/Talent"+str(skillNumber)).texture_disabled = load("res://SkillTree/Buttons/lifestealViolet.png")
			
			var listParry = [17,24,32,38]
			if(listParry.has(skillNumber)):
				get_node("VBoxContainer/ScrollContainer/Control/Talent"+str(skillNumber)).disabled = true
				get_node("VBoxContainer/ScrollContainer/Control/Talent"+str(skillNumber)).modulate = Color(1, 1, 1)
				get_node("VBoxContainer/ScrollContainer/Control/Talent"+str(skillNumber)).texture_disabled = load("res://SkillTree/Buttons/parryViolet.png")
			
			
			var listblock= [19,27,33,41]
			if(listblock.has(skillNumber)):
				get_node("VBoxContainer/ScrollContainer/Control/Talent"+str(skillNumber)).disabled = true
				get_node("VBoxContainer/ScrollContainer/Control/Talent"+str(skillNumber)).modulate = Color(1, 1, 1)
				get_node("VBoxContainer/ScrollContainer/Control/Talent"+str(skillNumber)).texture_disabled = load("res://SkillTree/Buttons/blockViolet.png")
			
			
			var bleed = [21,29,35,43]
			if(bleed.has(skillNumber)):
				get_node("VBoxContainer/ScrollContainer/Control/Talent"+str(skillNumber)).disabled = true
				get_node("VBoxContainer/ScrollContainer/Control/Talent"+str(skillNumber)).modulate = Color(1, 1, 1)
				get_node("VBoxContainer/ScrollContainer/Control/Talent"+str(skillNumber)).texture_disabled = load("res://SkillTree/Buttons/bleedViolet.png")
			
			
			var MS=[61]
			if(MS.has(skillNumber)):
				get_node("VBoxContainer/ScrollContainer/Control/Talent"+str(skillNumber)).disabled = true
				get_node("VBoxContainer/ScrollContainer/Control/Talent"+str(skillNumber)).modulate = Color(1, 1, 1)
				get_node("VBoxContainer/ScrollContainer/Control/Talent"+str(skillNumber)).texture_disabled = load("res://SkillTree/Buttons/msViolet.png")
			
			
			
			var thorns = [65]
			if(thorns.has(skillNumber)):
				get_node("VBoxContainer/ScrollContainer/Control/Talent"+str(skillNumber)).disabled = true
				get_node("VBoxContainer/ScrollContainer/Control/Talent"+str(skillNumber)).modulate = Color(1, 1, 1)
				get_node("VBoxContainer/ScrollContainer/Control/Talent"+str(skillNumber)).texture_disabled = load("res://SkillTree/Buttons/thornsViolet.png")
			
			
			var dash=[72]
			if(dash.has(skillNumber)):
				get_node("VBoxContainer/ScrollContainer/Control/Talent"+str(skillNumber)).disabled = true
				get_node("VBoxContainer/ScrollContainer/Control/Talent"+str(skillNumber)).modulate = Color(1, 1, 1)
				get_node("VBoxContainer/ScrollContainer/Control/Talent"+str(skillNumber)).texture_disabled = load("res://SkillTree/Buttons/dashViolet.png")
			
			var dodge=[73]
			if(dodge.has(skillNumber)):
				get_node("VBoxContainer/ScrollContainer/Control/Talent"+str(skillNumber)).disabled = true
				get_node("VBoxContainer/ScrollContainer/Control/Talent"+str(skillNumber)).modulate = Color(1, 1, 1)
				get_node("VBoxContainer/ScrollContainer/Control/Talent"+str(skillNumber)).texture_disabled = load("res://SkillTree/Buttons/dodgeViolet.png")
			
			var whirlwind=[74]
			if(whirlwind.has(skillNumber)):
				get_node("VBoxContainer/ScrollContainer/Control/Talent"+str(skillNumber)).disabled = true
				get_node("VBoxContainer/ScrollContainer/Control/Talent"+str(skillNumber)).modulate = Color(1, 1, 1)
				get_node("VBoxContainer/ScrollContainer/Control/Talent"+str(skillNumber)).texture_disabled = load("res://SkillTree/Buttons/wwViolet.png")
			
			var hybridHPArmor=[51,56,62,68]
			if(hybridHPArmor.has(skillNumber)):
				get_node("VBoxContainer/ScrollContainer/Control/Talent"+str(skillNumber)).disabled = true
				get_node("VBoxContainer/ScrollContainer/Control/Talent"+str(skillNumber)).modulate = Color(1, 1, 1)
				get_node("VBoxContainer/ScrollContainer/Control/Talent"+str(skillNumber)).texture_disabled = load("res://SkillTree/Buttons/hparmourMIX.png")
			
			var hybridArmorAttack=[52,58,64,70]
			if(hybridArmorAttack.has(skillNumber)):
				get_node("VBoxContainer/ScrollContainer/Control/Talent"+str(skillNumber)).disabled = true
				get_node("VBoxContainer/ScrollContainer/Control/Talent"+str(skillNumber)).modulate = Color(1, 1, 1)
				get_node("VBoxContainer/ScrollContainer/Control/Talent"+str(skillNumber)).texture_disabled = load("res://SkillTree/Buttons/aaMIX.png")
	
	
	for skillNumber in numberOfSkills:
		if(Skills[skillNumber]==0 and skillNumber==0):
			SetSkillToObtainable(skillNumber)
		if(Skills[skillNumber]==0 and skillNumber==1):
			SetSkillToObtainable(skillNumber)
		if(Skills[skillNumber]==0 and skillNumber==2):
			SetSkillToObtainable(skillNumber)
		
		if((Skills[skillNumber]==0 and skillNumber==3) and Skills[0]==1):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==4) and Skills[0]==1):
			SetSkillToObtainable(skillNumber)
		
		if((Skills[skillNumber]==0 and skillNumber==5) and Skills[1]==1):
			SetSkillToObtainable(skillNumber)
		
		if((Skills[skillNumber]==0 and skillNumber==6) and Skills[1]==1):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==7) and Skills[2]==1):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==8) and Skills[2]==1):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==9) and Skills[3]==1):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==10) and Skills[4]==1):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==11) and Skills[5]==1):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==12) and Skills[6]==1):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==13) and Skills[7]==1):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==14) and Skills[8]==1):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==15) and Skills[9]==1):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==16) and (Skills[9]==1 or Skills[10]==1)):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==17) and (Skills[10]==1 or Skills[11]==1)):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==18) and (Skills[11]==1 or Skills[12]==1)):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==19) and (Skills[12]==1 or Skills[13]==1)):
			SetSkillToObtainable(skillNumber)
		if((Skills[skillNumber]==0 and skillNumber==20) and (Skills[13]==1 or Skills[14]==1)):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==21) and (Skills[14]==1)):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==22) and (Skills[15]==1)):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==23) and (Skills[16]==1)):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==24) and (Skills[17]==1)):
			SetSkillToObtainable(skillNumber)
	
		if((Skills[skillNumber]==0 and skillNumber==25) and (Skills[18]==1)):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==26) and (Skills[18]==1)):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==27) and (Skills[19]==1)):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==28) and (Skills[20]==1)):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==29) and (Skills[21]==1)):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==30) and (Skills[22]==1)):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==31) and (Skills[23]==1)):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==32) and (Skills[24]==1)):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==33) and (Skills[27]==1)):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==34) and (Skills[28]==1)):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==35) and (Skills[29]==1)):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==36) and (Skills[30]==1)):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==37) and (Skills[31]==1)):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==38) and (Skills[32]==1)):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==39) and (Skills[25]==1)):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==40) and (Skills[26]==1)):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==41) and (Skills[33]==1)):
			SetSkillToObtainable(skillNumber)
		if((Skills[skillNumber]==0 and skillNumber==42) and (Skills[34]==1)):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==43) and (Skills[35]==1)):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==44) and (Skills[37]==1)):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==45) and (Skills[39]==1)):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==46) and (Skills[40]==1)):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==47) and (Skills[42]==1)):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==48) and (Skills[45]==1)):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==49) and (Skills[46]==1)):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==50) and (Skills[36]==1 or Skills[44]==1)):
			SetSkillToObtainable(skillNumber)
		if((Skills[skillNumber]==0 and skillNumber==51) and (Skills[44]==1 or Skills[48]==1)):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==52) and (Skills[49]==1 or Skills[47]==1)):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==53) and (Skills[47]==1 or Skills[43]==1)):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==54) and (Skills[48]==1 or Skills[49]==1)):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==55) and (Skills[50]==1)):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==56) and (Skills[51]==1)):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==57) and (Skills[54]==1)):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==58) and (Skills[52]==1)):
			SetSkillToObtainable(skillNumber)
		if((Skills[skillNumber]==0 and skillNumber==59) and (Skills[53]==1)):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==60) and (Skills[55]==1)):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==61) and (Skills[60]==1 or Skills[62]==1)):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==62) and (Skills[56]==1)):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==63) and (Skills[57]==1)):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==64) and (Skills[58]==1)):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==65) and (Skills[64]==1 or Skills[66]==1)):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==66) and (Skills[59]==1)):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==67) and (Skills[60]==1)):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==68) and (Skills[62]==1)):
			SetSkillToObtainable(skillNumber)
		if((Skills[skillNumber]==0 and skillNumber==69) and (Skills[63]==1)):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==70) and (Skills[64]==1)):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==71) and (Skills[66]==1)):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==72) and (Skills[67]==1 or Skills[68]==1)):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==73) and (Skills[69]==1)):
			SetSkillToObtainable(skillNumber)
			
		if((Skills[skillNumber]==0 and skillNumber==74) and (Skills[70]==1) or Skills[71]==1):
			SetSkillToObtainable(skillNumber)
		
	
func SetSkillToObtainable(skillNumber):
	get_node("VBoxContainer/ScrollContainer/Control/Talent"+str(skillNumber)).disabled = false
	get_node("VBoxContainer/ScrollContainer/Control/Talent"+str(skillNumber)).modulate = Color(1, 1, 1)
	
func AddSkillPointCount(boolvalue):
	if(boolvalue):
		availableSkillPoints=availableSkillPoints-1
		$VBoxContainer/Control/ColorRect/Control2/ColorRect/HBoxContainer/lblFreePointsCount.text=str(availableSkillPoints)
	else:
		availableSkillPoints=availableSkillPoints+1
		$VBoxContainer/Control/ColorRect/Control2/ColorRect/HBoxContainer/lblFreePointsCount.text=str(availableSkillPoints)
		
	print(availableSkillPoints)
	
	var Skills = Global.ActiveSkills
	if(availableSkillPoints<1):

		var numberOfSkills=Skills.size()
		
		#start with all disabled
		for skillNumber in numberOfSkills:
			if(Skills[skillNumber]==0 and get_node("VBoxContainer/ScrollContainer/Control/Talent"+str(skillNumber)).button_pressed==false):
				get_node("VBoxContainer/ScrollContainer/Control/Talent"+str(skillNumber)).disabled = true
				get_node("VBoxContainer/ScrollContainer/Control/Talent"+str(skillNumber)).modulate = Color(0.271, 0.271, 0.271)
			
	else:
				CheckPrerequisities()
	

