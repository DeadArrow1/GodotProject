extends CharacterBody2D

signal hitTaken

func take_damage(value):
	hitTaken.emit(value)



