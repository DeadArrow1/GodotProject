extends Node2D

func _ready():
	$AnimationPlayer.play("Killed")
	await $AnimationPlayer.animation_finished
	
	#uncomment for saving memory, corpses delete themselves
	#queue_free()
