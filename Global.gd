extends Node

var current_scene = null

var maxHealth=100
var health = 50
var XP=0
var XPlevelUP=100
var armor=10
var level=1
var attack=30
var skillPointCount=0





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

