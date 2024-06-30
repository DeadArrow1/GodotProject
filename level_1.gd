extends Node2D

var XPGainEnabled=true

func _on_child_exiting_tree(node):
	if node.has_method("GiveXP") and XPGainEnabled:
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




func _on_leave_level_1_area_body_entered(body):
	print("body entered")
	if body.is_in_group("Player"):
		%Interface.ShowUsePrompt(true)
		print("Player registered")


func _on_leave_level_1_area_body_exited(body):
	print("body left")
	if body.is_in_group("Player"):
		%Interface.ShowUsePrompt(false)
		print("Player registered")


func _on_leave_level_1_area_leave_level():
	XPGainEnabled=false
