extends CharacterBody2D

var lastDirectionIsRight=true

var attackIsPossible=false
var isAttacking=false

var AggroAcquired=false
var lastPlayerPosition : Vector2 = Vector2.ZERO

var dmgTakenRecord=0


@onready var animation_tree : AnimationTree = $AnimationTree
@onready var animation_tree2 : AnimationTree = $AnimationTree2

@onready var root = get_tree().get_root()
@onready var current_scene = root.get_child(root.get_child_count() - 1)


@onready var player = get_node("/root/"+current_scene.name+"/player")

signal health_changed

var direction : Vector2 = Vector2.ZERO

var health = 200.0
var XP_yield = 20

signal EnemySlain

func GiveXP():
	return XP_yield

func _ready():
	
	
	%ProgressBar.max_value=health
	animation_tree.active=true
	animation_tree2.active=true
	health_changed.emit(health)

	$SkeletonTexture/AttackHit/AttackArea.set_deferred("disabled", true)
	
func _process(delta):
	update_animation_parameters()
	
func _physics_process(delta):
	
	if(direction and !AggroAcquired):
		var positionX =  snapped(global_position.x,10)
		var positionY =  snapped(global_position.y,10)
		
		var playerPositionX= snapped(lastPlayerPosition.x,10)
		var playerPositionY= snapped(lastPlayerPosition.y,10)
		
		if(positionX == playerPositionX and positionY == playerPositionY):
			print("reached last known position")
			direction=Vector2.ZERO
		
	
	if(AggroAcquired):
		direction = global_position.direction_to(player.global_position)
	
	%ProgressBar.value = health
	if(!isAttacking):
	
		var left
		var right
		
		if direction:
			velocity = direction*100
		else:
			velocity= Vector2.ZERO
	
		if(velocity.x>0):
			right = true
			left = false
		if(velocity.x<0):
			left = true
			right = false
		
		if left and lastDirectionIsRight==true:
			%LabelPositionMarker.set_scale(Vector2(-1,1))
			set_scale(Vector2(-1,1))
			lastDirectionIsRight=false
		if right and lastDirectionIsRight==false:
			%LabelPositionMarker.set_scale(Vector2(1,1))
			set_scale(Vector2(-1,-1))
			lastDirectionIsRight=true
		
		
		move_and_slide()
	
func update_animation_parameters():
	#animation_tree2["parameters/conditions/damageTaken"] = false
	
	if(velocity == Vector2.ZERO):
		animation_tree["parameters/conditions/isIdle"] = true
		animation_tree["parameters/conditions/isMoving"] = false
	else:
		animation_tree["parameters/conditions/isIdle"] = false 
		animation_tree["parameters/conditions/isMoving"] = true
	if(attackIsPossible):
		
		animation_tree["parameters/conditions/isAttacking"]=true
	else:
		animation_tree["parameters/conditions/isAttacking"]=false
		
	animation_tree["parameters/idle/blend_position"] = direction
	animation_tree["parameters/attack/blend_position"] = direction
	animation_tree["parameters/idle/blend_position"] = direction
	
	
func RootEntity(value):
	isAttacking=value

func _on_attack_hit_body_entered(body):
	print("Skeleton hit registered")
	if body.is_in_group("Player"):
		body.take_damage(10)

func _on_line_of_sight_body_entered(body):
	if body.is_in_group("Player"):
		print("player entered LOS")
		AggroAcquired=true
		

func _on_line_of_sight_body_exited(body):
	if body.is_in_group("Player"):
		print("player exited LOS")
		AggroAcquired=false
		lastPlayerPosition = player.global_position.round()


func _on_hitbox_body_hit_taken(value):
	
	if(lastDirectionIsRight):
		position += Vector2(-20, 0)
	else:
		position += Vector2(20, 0)
	
	dmgTakenRecord-=value
	
	%LabelPositionMarker/HealthChangeLabel.text=str(-dmgTakenRecord)
	animation_tree2["parameters/conditions/damageTaken"] = true
	animation_tree2.get("parameters/playback").start("HPChange",true)
	
	health -= value
	if health <=0:
		queue_free()


func _on_attack_detection_body_entered(body):
	if body.is_in_group("Player"):
		print("player is in attack range")
		attackIsPossible=true


func _on_attack_detection_body_exited(body):
	if body.is_in_group("Player"):
		print("player left attack range")
		attackIsPossible=false
		
func resetDmgRecord():
	dmgTakenRecord=0

