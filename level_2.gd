extends Node2D

var XPGainEnabled=true

func _process(delta):
	if Input.is_action_just_pressed("PauseGame") and Global.isSkillTreeOpen==false:
		var pauseMenu = preload("res://pause_menu.tscn").instantiate()
		$InterfaceLayer.add_child(pauseMenu)
		Global.pauseGame(true)
	
	if(Global.enemiesCount==0):
		GiveEncounterRewards()
		Global.enemiesCount=-1
		Global.RecalculateStats()
		

func _ready():
	
	Global.PlayerModifiers=[0,0,0,0]
	Global.EnemyModifiers=[0,0,0]
	Global.PlayerRewards=[0,0,0,0,0]
	
	Global.enemiesCount=-1
	process_mode = Node.PROCESS_MODE_PAUSABLE
	Global.PresentOptions=[]
	Global.encounterStarted=false
	$InterfaceLayer/Interface/ColorRect3/GridContainer/lblArenaLevelNumber.text=str(Global.arenaLevel)
	
	Global.start_encounter.connect(begin_encounter)

func _on_child_exiting_tree(node):
	if node.has_method("GiveXP") and XPGainEnabled:
		var XPGain=node.XP_yield + node.XP_yield *(Global.PlayerModifiers[3]*0.01)
		print("XP GAIN: " + str(XPGain))
		
		get_node("player").UpdateXP(XPGain)
		

func _on_leave_area_leave_level():
	XPGainEnabled=false
	
func spawn_mob():
	var new_mob = preload("res://skeleton_warrior.tscn").instantiate()
	get_node("Path2D/PathFollow2D").progress_ratio=randf()
	new_mob.global_position=get_node("Path2D/PathFollow2D").global_position
	
	add_child(new_mob)

func begin_encounter():
	$InterfaceLayer/Interface.ShowUsePrompt(false)
	Global.encounterStarted=true
	Global.enemiesCount=4+Global.arenaLevel
	
	
	for n in Global.enemiesCount:
		spawn_mob()

func _on_child_entered_tree(node):
	if(node.has_method("setAggro")):
		node.setAggro(true)
		
func GiveEncounterRewards():
	
	for i in Global.PlayerRewardsAcquired.size():
		Global.PlayerRewardsAcquired[i]=Global.PlayerRewardsAcquired[i]+Global.PlayerRewards[i]
	
	
