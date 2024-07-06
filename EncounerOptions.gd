extends VBoxContainer

func _ready():
	Global.NumberOfCurrentlyShownActions=0
	
	add_option()
	add_option()
	add_option()
	
func add_option():
	var option = preload("res://EncounterOption.tscn").instantiate()
	
	add_child(option)
