extends Area2D

var can_start : bool
var leave_object

signal open_encounter_dialog
signal show_use_prompt


func _process(_delta):
	if Input.is_action_just_pressed("Use") and Global.encounterStarted==false:
		if can_start and leave_object:
			open_encounter_dialog.emit()

func _on_body_entered(body):
	if(body.is_in_group("Player") and Global.encounterStarted==false):
		can_start = true
		show_use_prompt.emit(true)
		leave_object = body


func _on_body_exited(body):
	if(body.is_in_group("Player") and Global.encounterStarted==false):
		show_use_prompt.emit(false)
		can_start = false
		
