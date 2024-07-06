extends Control

signal beginEncounter


func CloseDialog():
	queue_free()

func _on_cancel_button_pressed():
	CloseDialog()
	
func startEncounter(option):
	CloseDialog()




func _on_encounter_options_child_entered_tree(node):
	if(node.is_in_group("EncounterOption")):
		node.option_selected.connect(startEncounter)
