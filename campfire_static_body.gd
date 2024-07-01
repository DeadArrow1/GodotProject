extends StaticBody2D


var PlayerBody
var can_rest=false

signal player_present

func _ready():
	player_present.connect(Global.actionPossible)
	%FireSound.play()

func _process(_delta):
	if Input.is_action_pressed("Use"):
		if can_rest:
			PlayerBody.rest()


func _on_rest_area_body_entered(body):
	if body.is_in_group("Player"):
		can_rest=true
		PlayerBody=body
		player_present.emit(true)
 


func _on_rest_area_body_exited(body):
	if PlayerBody.is_in_group("Player"):
		can_rest=false
		player_present.emit(false)
