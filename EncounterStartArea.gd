extends Area2D

var can_start : bool
var leave_object

signal start_encounter
signal show_use_prompt


func _process(_delta):
	if Input.is_action_just_pressed("Use"):
		if can_start and leave_object:
			start_encounter.emit()

func _on_body_entered(body):
	if(body.is_in_group("Player")):
		can_start = true
		show_use_prompt.emit(true)
		leave_object = body


func _on_body_exited(body):
	if(body.is_in_group("Player")):
		show_use_prompt.emit(false)
		can_start = false
		
