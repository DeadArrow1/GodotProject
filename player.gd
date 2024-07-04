extends CharacterBody2D

var lastDirectionIsRight=true

var resting = false
var isAttacking=false

var attackComboContinues=false

@onready var animation_tree : AnimationTree = $AnimationTree

signal health_changed
signal maxHealth_changed
signal XP_changed

signal attack_changed
signal armor_changed
signal level_changed


var direction : Vector2 = Vector2.ZERO

var maxHealth=Global.maxHealth


func _ready():
	health_changed.connect(Global._on_player_health_changed)
	maxHealth_changed.connect(Global._on_player_max_health_changed)
	XP_changed.connect(Global._on_player_xp_changed)

	attack_changed.connect(Global._on_player_attack_changed)
	armor_changed.connect(Global._on_player_armor_changed)
	level_changed.connect(Global._on_player_level_changed)
	
	
	animation_tree.active=true
	maxHealth_changed.emit(Global.maxHealth)
	health_changed.emit(Global.health)
	XP_changed.emit(Global.XP,Global.XPlevelUP)
	
	attack_changed.emit(Global.attack)
	armor_changed.emit(Global.armor)
	level_changed.emit(Global.level,Global.skillPointCount)
	
	
	
	
	
	
	
	$KnightNew/SwordHit/HitArea.set_deferred("disabled", true)
	
func _process(delta):
	update_animation_parameters()
	
	
	
func _physics_process(delta):
	if(!isAttacking):
	
		direction = Input.get_vector("move_left","move_right","move_up","move_down")
		
		var right = Input.is_action_just_pressed("move_right")
		var left = Input.is_action_just_pressed("move_left")
		
		var up=Input.is_action_just_pressed("move_up")
		var down= Input.is_action_just_pressed("move_down")
		
		if(right or left or up or down):
			resting=false
		
		
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
			
		if(Input.is_action_just_pressed("MouseWheelUp")):
			if(%PlayerCamera.zoom.x < 3 and %PlayerCamera.zoom.y < 3):
				%PlayerCamera.zoom.x+=0.1
				%PlayerCamera.zoom.y+=0.1
		if(Input.is_action_just_pressed("MouseWheelDown")):
			if(%PlayerCamera.zoom.x > 2 and %PlayerCamera.zoom.y > 2):
				%PlayerCamera.zoom.x-=0.1
				%PlayerCamera.zoom.y-=0.1
		
		move_and_slide()
	
func update_animation_parameters():
	if(velocity == Vector2.ZERO):
		animation_tree["parameters/conditions/isIdle"] = true
		animation_tree["parameters/conditions/isMoving"] = false
		
	else:
		animation_tree["parameters/conditions/isIdle"] = false 
		animation_tree["parameters/conditions/isMoving"] = true
		
	if(animation_tree["parameters/conditions/isMoving"] == false):
		%RunSound.play()
	
		
		
	if(Input.is_action_just_pressed("attack_basic")):
		if(isAttacking==true):
			attackComboContinues=true
			animation_tree["parameters/conditions/isComboContinuing"]=true
		else:
			animation_tree["parameters/conditions/isAttacking"]=true
	else:
		animation_tree["parameters/conditions/isAttacking"]=false
		
		
		
		
		
		
	if(resting):
		animation_tree["parameters/conditions/isIdle"] = false
		animation_tree["parameters/conditions/isMoving"] = false
		animation_tree["parameters/conditions/isResting"] = true
	else:
		animation_tree["parameters/conditions/isResting"] = false
	animation_tree["parameters/idle/blend_position"] = direction
	animation_tree["parameters/attack/blend_position"] = direction
	animation_tree["parameters/idle/blend_position"] = direction
	
	
func RootKnight(value):
	isAttacking=value

func ResetAttackCombo(value):
	attackComboContinues=value
	animation_tree["parameters/conditions/isComboContinuing"]=value
	

func UpdateXP(value):
	Global.XP=Global.XP+value
	
	if(Global.XP>=Global.XPlevelUP):
		Global.skillPointCount=Global.skillPointCount+1
		level_changed.emit(Global.level+1,Global.skillPointCount)
		Global.XP=Global.XP-Global.XPlevelUP
		Global.XPlevelUP=Global.XPlevelUP*2
	XP_changed.emit(Global.XP,Global.XPlevelUP)
	print(Global.XP)




func _on_sword_hit_body_entered(body):
	
	print("ok registered")
	if body.is_in_group("Enemy"):
		body.take_damage(Global.attack)


func _on_hit_box_hit_taken(value):
	Global.health -= value
	health_changed.emit(Global.health)
	
	if(Global.health <=0):
		Global.goto_scene("res://game_over_screen.tscn")
		
func rest():
	resting=true

func regeneration(value):
	if(Global.health<Global.maxHealth):
		if(Global.health+value > Global.maxHealth):
			Global.health=Global.maxHealth
		else:
			Global.health+=value
		health_changed.emit(Global.health)
func setIsAttackingParameter(boolvalue):
	animation_tree["parameters/conditions/isAttacking"]=boolvalue
	
func playAttackSound(number):
	if(number==1):
		%Attack1Sound.play()
	if(number==2):
		%Attack2Sound.play()
	if(number==3):
		%Attack3Sound.play()
