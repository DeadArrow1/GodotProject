extends Node2D

var XPGainEnabled=true

func _ready():
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
	spawn_mob()
	spawn_mob()
	spawn_mob()
	spawn_mob()
	spawn_mob()

func _on_child_entered_tree(node):
	if(node.has_method("setAggro")):
		node.setAggro(true)


func _on_interface_start_encounter():
	$InterfaceLayer/Interface.ShowUsePrompt(false)
	Global.encounterStarted=true
	begin_encounter()
