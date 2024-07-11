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
var movementSpeed
var arenaLevel=1

var maxHealthBase=100
var healthBase= 50
var XPBase=0
var XPlevelUPBase=100
var armorBase=10
var levelBase=1
var attackBase=30
var skillPointCountBase=0

var movementSpeedBase=300




#encounterOptions
#encounter = [name,description,PlayerModifiers[health,damage,armor,XP],enemy modifiers[health,damage],rewards[Maxhealth,damage,armor,XP,gold],image]
var encounterOption1 = ["Ser Hervis's wisdom", "+ 25% XP gain from this encounter", [0,0,0,25],[0,0,0],[0,0,0,0,0], "res://EncounterOptionXPBackgroundColorBook.png"]
var encounterOption2 = ["Trial by combat", "+ 5 damage after this encounter, enemies deal 50% more damage", [0,0,0,0],[0,50],[0,5,0,0,0], "res://EncounterOptionBattleBackground.png"]
var encounterOption3 = ["The higher the better", "Enemies have 25% more HP. +30% XP gain from this encounter.", [0,0,0,30],[25,0,0],[0,0,0,0,0], "res://EncounterOptionXPBackgroundColorBook.png"]

var encounterOption4 = ["Run for life", "+30 HP from this encounter. Enemies move 50% faster.", [0,0,0,0],[0,0,50],[30,0,0,0,0], "res://EncounterOptionBattleBackground.png"]
var encounterOption5 = ["Beefy rewards", "+40 attack damage from this encounter. Enemies have 20% more HP and damage.", [0,0,0,0],[20,20,0],[0,40,0,0,0], "res://EncounterOptionBattleBackground.png"]
var encounterOption6 = ["Man up", "-10 Armour. Enemies have +10% HP.", [0,0,-10,0],[10,0,0],[0,0,0,0,0], "res://EncounterOptionBattleBackground.png"]



var encounterOptions=[encounterOption1,encounterOption2,encounterOption3,encounterOption4,encounterOption5,encounterOption6]
var PresentOptions=[]

var NumberOfCurrentlyShownActions
#ENCOUNTERS END####################################

#MODIFIERS####################
#[health,damage,armor,XP]
var PlayerModifiers=[0,0,0,0]

#[health,damage]
var EnemyModifiers=[0,0,0]
#MODIFIERS###################


var encounterStarted

#####SKILL TREE
var ActiveSkills

#SKILLS

#HP,HP%,ARMOR,ARMOR%,ATTACKDMG,ATTACKDMG%,MOVEMENTSPEED%

var skillEffects=[  [10,0,0,0,0,0,0],
					[0,0,20,0,0,0,0],
					[0,0,0,0,10,0,0],
					[10,0,0,0,0,0,0],
					[10,0,0,0,0,0,0],
					[0,0,20,0,0,0,0],
					[0,0,20,0,0,0,0],
					[0,0,0,0,10,0,0],
					[0,0,0,0,10,0,0],
					[10,0,0,0,0,0,0],
					[10,0,0,0,0,0,0],
					###0-10 SKILLS
					[0,0,20,0,0,0,0],
					[0,0,20,0,0,0,0],
					[0,0,0,0,10,0,0],
					[0,0,0,0,10,0,0],
					[0,0,0,0,0,0,0],
					[50,0,0,0,0,0,0],
					[0,0,0,0,0,0,0],
					[0,0,200,0,0,0,0],
					[0,0,0,0,0,0,0],
					[0,0,0,0,40,0,0],
					#SKILLS 11-20
					[0,0,0,0,0,0,0],
					[0,0,0,0,0,0,0],
					[15,0,0,0,0,0,0],
					[0,0,0,0,0,0,0],
					[0,0,30,0,0,0,0],
					[0,0,30,0,0,0,0],
					[0,0,0,0,0,0,0],
					[0,0,0,0,15,0,0],
					[0,0,0,0,0,0,0],
					[0,0,0,0,0,0,0],
					##SKILLS 21-30
					[15,0,0,0,0,0,0],
					[0,0,0,0,0,0,0],
					[0,0,0,0,0,0,0],
					[0,0,0,0,15,0,0],
					[0,0,0,0,0,0,0],
					[0,0,0,0,0,0,0],
					[15,0,0,0,0,0,0],
					[0,0,0,0,0,0,0],
					[0,0,30,0,0,0,0],
					[0,0,30,0,0,0,0],
					##SKILLS 31-40
					[0,0,0,0,0,0,0],
					[0,0,0,0,15,0,0],
					[0,0,0,0,0,0,0],
					[15,0,0,0,0,0,0],
					[0,0,30,0,0,0,0],
					[0,0,30,0,0,0,0],
					[0,0,0,0,15,0,0],
					[0,0,30,0,0,0,0],
					[0,0,30,0,0,0,0],
					[30,25,0,0,0,0,0],
					#SKILLS 41-50
					[15,15,150,10,0,0,0],
					[0,0,150,10,20,10,0],
					[0,0,0,0,40,20,0],
					[0,0,300,20,0,0,0],
					[15,0,0,0,0,0,0],
					[10,0,15,0,0,0,0],
					[0,0,30,0,0,0,0],
					[0,0,15,0,10,0,0],
					[0,0,0,0,15,0,0],
					[15,0,0,0,0,0,0],
					##SKILLS 51-60
					[0,0,0,0,0,0,25],
					[10,0,15,0,0,0,0],
					[0,0,30,0,0,0,0],
					[0,0,15,0,10,0,0],
					[0,0,0,0,0,0,0],
					[0,0,0,0,15,0,0],
					[15,0,0,0,0,0,0],
					[10,0,15,0,0,0,0],
					[0,0,0,30,0,0,0],
					[0,0,15,0,10,0,0],
					#SKILLS 61-70
					[0,0,0,0,15,0,0],
					[0,0,0,0,0,0,0],
					[0,0,0,0,0,0,0],
					[0,0,0,0,0,0,0],
					[0,0,0,0,0,0,0]
]


func InitializeSkills():
	ActiveSkills = []
	for n in 75:	
		ActiveSkills.append(0)
	print(ActiveSkills.size())




#####SKILL TREE END






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
	
func pauseGame(boolvalue):
	get_tree().paused=boolvalue
	
	
	
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
	
	
	
	


