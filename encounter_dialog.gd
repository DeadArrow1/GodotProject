extends Control

signal beginEncounter

func _ready():
	Global.pauseGame(true)


func CloseDialog(option):
	Global.pauseGame(false)
	queue_free()
	
func CloseDialog2():
	Global.pauseGame(false)
	queue_free()

func _on_cancel_button_pressed():
	CloseDialog2()

func _on_encounter_options_child_entered_tree(node):
	if(node.is_in_group("EncounterOption")):
		node.option_selected.connect(CloseDialog)
