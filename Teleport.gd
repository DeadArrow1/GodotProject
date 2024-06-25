extends Area2D

var can_teleport : bool
var teleport_object

@export var destination = Vector2(0,0)

func _process(_delta):
	if Input.is_action_pressed("Use"):
		if can_teleport and teleport_object:
				_teleport()


func _on_body_entered(body):
	can_teleport = true
	teleport_object = body


func _on_body_exited(body):
	can_teleport = false
	
func _teleport():
	if teleport_object.is_in_group("Player"):
		
		teleport_object.position += Vector2(100, 0)
		
