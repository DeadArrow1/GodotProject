extends Node2D


func _on_player_health_changed(health):
	%Interface.UpdateHealthBar(health)


func _on_player_xp_changed(XP,XPlevelUP):
	%Interface.UpdateXPBar(XP,XPlevelUP)


func _on_child_exiting_tree(node):
	if node.has_method("GiveXP"):
		var XPGain=node.XP_yield
		
		%player.UpdateXP(XPGain)
		


func _on_teleport_body_entered(body):
	print("body entered")
	if body.is_in_group("Player"):
		%Interface.ShowUsePrompt(true)
		print("Player registered")


func _on_teleport_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	print("body left")
	if body.is_in_group("Player"):
		%Interface.ShowUsePrompt(false)
		print("Player registered")


func _on_player_armor_changed(value):
	%Interface.UpdateArmor(value)


func _on_player_attack_changed(value):
	%Interface.UpdateAttack(value)


func _on_player_level_changed(value,skillPointCount):
	%Interface.UpdateLevel(value)
	
	%Interface.ShowBntSkillPoint(true,skillPointCount)


func _on_player_max_health_changed(value):
	%Interface.UpdateMaxHealth(value)
