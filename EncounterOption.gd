extends HBoxContainer

signal option_selected

var PickOption

func _ready():
	
	if(Global.PresentOptions.size() < 3):
		var numberOfEncounters = Global.encounterOptions.size()
		
		
		PickOption = randi_range(0,numberOfEncounters-1)
		while(Global.PresentOptions.has(PickOption) == true):
			PickOption = randi_range(0,numberOfEncounters-1)
		
		Global.PresentOptions.append(PickOption)
		
		var array = Global.PresentOptions
		prepareOption(Global.encounterOptions[PickOption])
	else:
			prepareOption(Global.encounterOptions[Global.PresentOptions[Global.NumberOfCurrentlyShownActions]])
			PickOption=Global.PresentOptions[Global.NumberOfCurrentlyShownActions]
			

			
			Global.NumberOfCurrentlyShownActions = Global.NumberOfCurrentlyShownActions+1
			
			
			
	option_selected.connect(Global.editModifiers)
func _on_button_pressed():
		option_selected.emit(Global.encounterOptions[PickOption])

	
func prepareOption(option):
	get_node("ColorRect/OptionBackground").texture = load(option[5])
	get_node("ColorRect/lblEncounter1Name").text = option[0]
	get_node("lblDescription").text = option[1]
