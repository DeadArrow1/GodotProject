extends Control

var oldHPValue

var skill_tree

signal startEncounter

	
func _ready():
	get_node("ColorRect/AnimationTree").active=true
	oldHPValue=0
	
	
	
func UpdateHealthBar(value):
	
	oldHPValue=get_node("ColorRect/BoxContainer/HealthBar").value
	get_node("ColorRect/BoxContainer/HealthBar").set_value(value)
	
	var healthChange=get_node("ColorRect/BoxContainer/HealthBar").value - oldHPValue 
	if(healthChange > 0):
		var green = Color(0, 0.918, 0)
		get_node("ColorRect/BoxContainer/HealthBar/HealthChangeLabel").set("theme_override_colors/font_color",green)
		get_node("ColorRect/BoxContainer/HealthBar/HealthChangeLabel").text="+"+str(healthChange)
	else:
		var red = Color(0.775, 0.139, 0.154)
		get_node("ColorRect/BoxContainer/HealthBar/HealthChangeLabel").set("theme_override_colors/font_color",red)
		get_node("ColorRect/BoxContainer/HealthBar/HealthChangeLabel").text=str(healthChange)
		
	get_node("ColorRect/AnimationTree")["parameters/conditions/HPChanged"] = true
	
func UpdateXPBar(XPvalue,XPlevelUPvalue):
	get_node("ColorRect/BoxContainer/ExperienceBar").max_value=XPlevelUPvalue
	get_node("ColorRect/BoxContainer/ExperienceBar").set_value(XPvalue)
	
	
	get_node("ColorRect/BoxContainer/ExperienceBar/ExperienceNumbers").text=str(XPvalue)+"/"+str(XPlevelUPvalue)
	
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
	get_node("ColorRect/AnimationTree")["parameters/conditions/HPChanged"] = boolvalue

func _on_health_bar_value_changed(value):
	if(oldHPValue<value):
		get_node("ColorRect/HealthTakenBar").set_value(value)
	if(oldHPValue>value):
		while(get_node("ColorRect/HealthTakenBar").value > get_node("ColorRect/BoxContainer/HealthBar").value):
			await get_tree().create_timer(0.2).timeout
			get_node("ColorRect/HealthTakenBar").set_value(get_node("ColorRect/HealthTakenBar").value-1)
			
		


func _on_leave_area_show_use_prompt(boolvalue):
	ShowUsePrompt(boolvalue)


func _on_encounter_start_area_show_use_prompt(boolvalue):
	ShowUsePrompt(boolvalue)


func _on_btn_skill_point_pressed():
	skill_tree = preload("res://skill_tree.tscn").instantiate()
	add_child(skill_tree)


func _on_encounter_start_area_open_encounter_dialog():
	skill_tree = preload("res://encounter_dialog.tscn").instantiate()
	add_child(skill_tree)


func _on_child_entered_tree(node):
		if(node.is_in_group("Encounter")):
			node.beginEncounter.connect(begin_encounter)

func begin_encounter():
	startEncounter.emit()
