extends Node

var current_scene = null

var maxHealth
var health
var XP
var XPlevelUP
var armor
var level
var attack
var skillPointCount


#encounterOptions
#encounter = [name,description,PlayerModifiers[health,damage,armor,XP],enemy modifiers[health,damage],rewards[Maxhealth,damage,armor,XP,gold],image]
var encounterOption1 = ["Ser Hervis's wisdom", "+ 25% XP gain from this encounter", [0,0,0,25],[0,0],[0,0,0,0,0], "res://EncounterOptionXPBackground.png"]
var encounterOption2 = ["Trial by combat", "+ 5 damage after this encounter, enemies deal 50% more damage", [0,0,0,0],[0,50],[0,5,0,0,0], "res://EncounterOptionXPBackground.png"]
var encounterOption3 = ["Gold rush", "+50 gold after this encounter", [0,0,0,0],[0,0],[0,0,0,0,5], "res://EncounterOptionXPBackground.png"]

var encounterOptions=[encounterOption1,encounterOption2,encounterOption3]
var PresentOptions=[]

var NumberOfCurrentlyShownActions
#ENCOUNTERS END####################################

#MODIFIERS####################
#[health,damage,armor,XP]
var PlayerModifiers=[0,0,0,0]

#[health,damage]
var EnemyModifiers=[0,0]
#MODIFIERS###################


var encounterStarted


func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)
	print(current_scene.get_path())

func goto_scene(path):
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:

	call_deferred("_deferred_goto_scene", path)


func _deferred_goto_scene(path):
	# It is now safe to remove the current scene
	current_scene.free()

	# Load the new scene.
	var s = ResourceLoader.load(path)

	# Instance the new scene.
	
	
	current_scene = s.instantiate()

	# Add it to the active scene, as child of root.
	get_tree().get_root().add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene() API.
	get_tree().set_current_scene(current_scene)
	
func _on_player_health_changed(health):
	var Interface = get_node("/root/"+current_scene.name+"/InterfaceLayer/Interface")
	Interface.UpdateHealthBar(health)
	
func _on_player_armor_changed(value):
	var Interface = get_node("/root/"+current_scene.name+"/InterfaceLayer/Interface")
	Interface.UpdateArmor(value)


func _on_player_attack_changed(value):
	var Interface = get_node("/root/"+current_scene.name+"/InterfaceLayer/Interface")
	Interface.UpdateAttack(value)


func _on_player_level_changed(value,skillPointCount):
	var Interface = get_node("/root/"+current_scene.name+"/InterfaceLayer/Interface")
	Interface.UpdateLevel(value)
	
	Interface.ShowBntSkillPoint(true,skillPointCount)


func _on_player_max_health_changed(value):
	var Interface = get_node("/root/"+current_scene.name+"/InterfaceLayer/Interface")
	Interface.UpdateMaxHealth(value)

func _on_player_xp_changed(XP,XPlevelUP):
	var Interface = get_node("/root/"+current_scene.name+"/InterfaceLayer/Interface")
	Interface.UpdateXPBar(XP,XPlevelUP)
	
func actionPossible(value):
	var Interface = get_node("/root/"+current_scene.name+"/InterfaceLayer/Interface")
	Interface.ShowUsePrompt(value)
	
	
signal start_encounter
func editModifiers(option):
	PlayerModifiers=option[2]
	EnemyModifiers=option[3]
	print("PlayerModifiers")
	print(PlayerModifiers)
	
	print("EnemyModifiers")
	print(EnemyModifiers)
	
	print("Encounter started")
	start_encounter.emit()
	
	
	
	


