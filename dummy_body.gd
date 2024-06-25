extends CharacterBody2D

var health = 100
var XP_yield = 10

signal EnemySlain

func _physics_process(delta):
	%ProgressBar.value = health

		
func GiveXP():
	return XP_yield


func _on_character_body_2d_hit_taken(value):
	health -= value
	if health <=0:
		queue_free()
