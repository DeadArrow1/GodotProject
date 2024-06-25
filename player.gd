extends CharacterBody2D

var lastDirectionIsRight=true

var isAttacking=false
@onready var animation_tree : AnimationTree = $AnimationTree

signal health_changed
signal maxHealth_changed
signal XP_changed

signal attack_changed
signal armor_changed
signal level_changed


var direction : Vector2 = Vector2.ZERO

var maxHealth=100

var health = 50
var XP=0
var XPlevelUP=100
var armor=10
var level=1
var attack=30
var skillPointCount=0

func _ready():
	animation_tree.active=true
	maxHealth_changed.emit(maxHealth)
	health_changed.emit(health)
	XP_changed.emit(XP,XPlevelUP)
	
	attack_changed.emit(attack)
	armor_changed.emit(armor)
	level_changed.emit(level,skillPointCount)
	
	
	
	
	
	
	
	$KnightNew/SwordHit/CollisionShape2D.set_deferred("disabled", true)
	
func _process(delta):
	update_animation_parameters()
	
func _physics_process(delta):
	if(!isAttacking):
	
		direction = Input.get_vector("move_left","move_right","move_up","move_down")
		
		var right = Input.is_action_just_pressed("move_right")
		var left = Input.is_action_just_pressed("move_left")
		
		if left and lastDirectionIsRight==true:
			set_scale(Vector2(-1,1))
			lastDirectionIsRight=false
		if right and lastDirectionIsRight==false:
			set_scale(Vector2(-1,-1))
			lastDirectionIsRight=true
		
		if direction:
			velocity = direction*500
		else:
			velocity= Vector2.ZERO
		move_and_slide()
	
func update_animation_parameters():
	if(velocity == Vector2.ZERO):
		animation_tree["parameters/conditions/isIdle"] = true
		animation_tree["parameters/conditions/isMoving"] = false
	else:
		animation_tree["parameters/conditions/isIdle"] = false 
		animation_tree["parameters/conditions/isMoving"] = true
	if(Input.is_action_just_pressed("attack_basic")):
		print("ok attack")
		animation_tree["parameters/conditions/isAttacking"]=true
	else:
		animation_tree["parameters/conditions/isAttacking"]=false
		
	animation_tree["parameters/idle/blend_position"] = direction
	animation_tree["parameters/attack/blend_position"] = direction
	animation_tree["parameters/idle/blend_position"] = direction
	
	
func RootKnight(value):
	isAttacking=value

func UpdateXP(value):
	XP=XP+value
	
	if(XP>=XPlevelUP):
		skillPointCount=skillPointCount+1
		level_changed.emit(level+1,skillPointCount)
		XP=XP-XPlevelUP
		XPlevelUP=XPlevelUP*2
	XP_changed.emit(XP,XPlevelUP)
	print(XP)




func _on_sword_hit_body_entered(body):
	
	print("ok registered")
	if body.is_in_group("Enemy"):
		body.take_damage(attack)


func _on_hit_box_hit_taken(value):
	health -= value
	health_changed.emit(health)
