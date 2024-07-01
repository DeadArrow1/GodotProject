extends Node2D

var XPGainEnabled=true

func _on_child_exiting_tree(node):
	if node.has_method("GiveXP") and XPGainEnabled:
		var XPGain=node.XP_yield
		
		get_node("player").UpdateXP(XPGain)
		


