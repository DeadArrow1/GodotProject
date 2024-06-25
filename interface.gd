extends Control

func UpdateHealthBar(value):
	get_node("ColorRect/BoxContainer/HealthBar").set_value(value)
	
func UpdateXPBar(XPvalue,XPlevelUPvalue):
	get_node("ColorRect/BoxContainer/ExperienceBar").max_value=XPlevelUPvalue
	get_node("ColorRect/BoxContainer/ExperienceBar").set_value(XPvalue)
	
	
	%ExperienceNumbers.text=str(XPvalue)+"/"+str(XPlevelUPvalue)
	
func ShowUsePrompt(boolValue):
	get_node("UsePrompt").visible=boolValue

func UpdateMaxHealth(value):
	get_node("ColorRect2/GridContainer/MaxHealthValue").text=str(value)
	get_node("ColorRect/BoxContainer/HealthBar").max_value=value
	
func UpdateAttack(value):
	get_node("ColorRect2/GridContainer/AttackValue").text=str(value)

func UpdateArmor(value):
	get_node("ColorRect2/GridContainer/ArmorValue").text=str(value)

func UpdateLevel(value):
	get_node("ColorRect2/GridContainer/LevelValue").text=str(value)
	
func ShowBntSkillPoint(show,skillPointCount):
	if(skillPointCount>0):
		get_node("btnSkillPoint").visible=show
		get_node("btnSkillPoint/lblFreeSkillPointCount").text=str(skillPointCount)

