extends Node2D

var XPGainEnabled=true

func _process(delta):
	if Input.is_action_just_pressed("PauseGame"):
		var pauseMenu = preload("res://pause_menu.tscn").instantiate()
		$InterfaceLayer.add_child(pauseMenu)
		Global.pauseGame(true)
		

func _ready():
	process_mode = Node.PROCESS_MODE_PAUSABLE
	Global.PresentOptions=[]
	Global.encounterStarted=false
	
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
	
	spawn_mob()
	spawn_mob()
	spawn_mob()
	spawn_mob()
	spawn_mob()

func _on_child_entered_tree(node):
	if(node.has_method("setAggro")):
		node.setAggro(true)
	
