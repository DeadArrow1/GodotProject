extends Control

var oldHPValue

	
func _ready():
	%AnimationTree.active=true
	oldHPValue=0
	
	
func UpdateHealthBar(value):
	oldHPValue=%HealthBar.value
	get_node("ColorRect/BoxContainer/HealthBar").set_value(value)
	
	var healthChange=%HealthBar.value - oldHPValue 
	if(healthChange > 0):
		var green = Color(0, 0.918, 0)
		%HealthChangeLabel.set("theme_override_colors/font_color",green)
		%HealthChangeLabel.text="+"+str(healthChange)
	else:
		var red = Color(0.775, 0.139, 0.154)
		%HealthChangeLabel.set("theme_override_colors/font_color",red)
		%HealthChangeLabel.text=str(healthChange)
		
	%AnimationTree["parameters/conditions/HPChanged"] = true
	
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

func setHPChangedParameter(boolvalue):
	%AnimationTree["parameters/conditions/HPChanged"] = boolvalue

func _on_health_bar_value_changed(value):
	if(oldHPValue<value):
		%HealthTakenBar.set_value(value)
	if(oldHPValue>value):
		while(%HealthTakenBar.value > %HealthBar.value):
			await get_tree().create_timer(0.2).timeout
			%HealthTakenBar.set_value(%HealthTakenBar.value-1)
			
		
