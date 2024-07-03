extends Node2D

var XPGainEnabled=true



func _on_child_exiting_tree(node):
	if node.has_method("GiveXP") and XPGainEnabled:
		var XPGain=node.XP_yield
		
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


func _on_encounter_start_area_start_encounter():
	begin_encounter()
