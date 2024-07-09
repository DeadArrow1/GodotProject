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
