extends Control

var hp_button_pressed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if(Global.fifty_hp_acquired):
		get_node("Background/HP++").button_pressed = true
		#get_node("HP++").disabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_confirm_pressed():
	if (hp_button_pressed == true and Global.fifty_hp_acquired == false):
		#print(Global.maxHealth)
		Global.maxHealth += 50
		#print(Global.maxHealth)
		Global.fifty_hp_acquired = true
	set_scale(Vector2(0,0))
		
		


func _on_hp_toggled(toggled_on):
	hp_button_pressed = toggled_on

func _input(ev):
	if Input.is_key_pressed(KEY_ESCAPE):
		print("EscapeKeyPressed")
		get_node(".").set_scale(Vector2(0,0))
