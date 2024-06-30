extends Area2D

var can_leave : bool
var leave_object

signal leave_level


func _process(_delta):
	if Input.is_action_pressed("Use"):
		if can_leave and leave_object:
			_teleport()

func _on_body_entered(body):
	if(body.is_in_group("Player")):
		can_leave = true
		leave_object = body


func _on_body_exited(body):
	if(body.is_in_group("Player")):
		can_leave = false
	
func _teleport():
	if leave_object.is_in_group("Player"):
		leave_level.emit()
		Global.goto_scene("res://level_2.tscn")
