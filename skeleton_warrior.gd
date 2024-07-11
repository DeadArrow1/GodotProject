extends CharacterBody2D

var lastDirectionIsRight=true

var attackIsPossible=false
var isAttacking=false

var AggroAcquired=false
var lastPlayerPosition : Vector2 = Vector2.ZERO

var dmgTakenRecord=0

var unlimited_aggro


@onready var animation_tree : AnimationTree = $AnimationTree
@onready var animation_tree2 : AnimationTree = $AnimationTree2

@onready var root = get_tree().get_root()
@onready var current_scene = root.get_child(root.get_child_count() - 1)


@onready var player = get_node("/root/"+current_scene.name+"/player")

signal health_changed

var direction : Vector2 = Vector2.ZERO

var healthSkeleton = 200.0 + 10 * Global.arenaLevel
var XP_yield = 100 + 5 * Global.arenaLevel
var damage = 10 + 5 * Global.arenaLevel

signal EnemySlain

func GiveXP():
	return XP_yield

func _ready():
	damage = damage + damage * Global.EnemyModifiers[1]*0.01
	healthSkeleton = healthSkeleton + healthSkeleton * Global.EnemyModifiers[0]*0.01
	
	%ProgressBar.max_value=healthSkeleton
	animation_tree.active=true
	animation_tree2.active=true
	health_changed.emit(healthSkeleton)

	$SkeletonTexture/AttackHit/AttackArea.set_deferred("disabled", true)
	$SkeletonTexture/ParryWindow/ParryShape.set_deferred("disabled", true)
	
func _process(delta):
	if(animation_tree["parameters/conditions/Stunned"] == false):
		$StunVisual.visible=false
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
		
	
	if(AggroAcquired || unlimited_aggro):
		direction = global_position.direction_to(player.global_position)
	
	%ProgressBar.value = healthSkeleton
	if(!isAttacking and animation_tree["parameters/conditions/isHit"] == false):
	
		var left
		var right
		
		if direction:
			velocity = direction*(100 + Global.EnemyModifiers[2])
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
		body.take_damage(damage)
		
		if(Global.ActiveSkills[65]==1):
			$HitboxBody.take_damage(20)
		

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
	
	if(Global.ActiveSkills[21]==1):
		if(Global.health<Global.maxHealth):	
			var lifestealAmmount=Global.ActiveSkills[21]*10 + Global.ActiveSkills[29]*5+Global.ActiveSkills[35]*5+Global.ActiveSkills[43]*10	
			Global.health=Global.health+lifestealAmmount
			Global._on_player_health_changed(Global.health)
	
	%LabelPositionMarker/HealthChangeLabel.text=str(-dmgTakenRecord)
	animation_tree2["parameters/conditions/damageTaken"] = true
	animation_tree2.get("parameters/playback").start("HPChange",true)
	
	if(animation_tree["parameters/conditions/Stunned"] == false):
		animation_tree["parameters/conditions/isHit"] = true
		animation_tree.get("parameters/playback").start("hitrecieved",true)
		animation_tree["parameters/conditions/isAttacking"] = false 
		animation_tree["parameters/conditions/isIdle"] = false 
		animation_tree["parameters/conditions/isMoving"] = false
	
	healthSkeleton -= value
	if healthSkeleton <=0:
		Global.enemiesCount=Global.enemiesCount-1
		queue_free()
		const corpse = preload("res://dead_skeleton.tscn")
		var newCorpse = corpse.instantiate()
		get_parent().add_child(newCorpse)
		newCorpse.global_position = global_position
		
		var bodyscale=$SkeletonTexture.scale
		var entityScale=scale.y
		
		if(entityScale<0):
			bodyscale.x=bodyscale.x*(-1)
		
		newCorpse.scale=bodyscale


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

func setAggro(boolvalue):
	unlimited_aggro=boolvalue
	


func _on_parry_window_get_stun():
	if(lastDirectionIsRight):
		position += Vector2(-100, 0)
	else:
		position += Vector2(100, 0)
		
	if(Global.ActiveSkills[24]==1):
		var stunLenght=Global.ActiveSkills[24]*0.25 + Global.ActiveSkills[32]*0.25 + Global.ActiveSkills[38]*0.5
		
		animation_tree["parameters/conditions/isIdle"] = true
		animation_tree["parameters/conditions/isMoving"] = false
		animation_tree["parameters/stunned/0/TimeScale/scale"]=1/stunLenght
		setStunnedParameter(true)
	
	
func setStunnedParameter(boolvalue):
	animation_tree["parameters/conditions/Stunned"] = boolvalue

func setIsHitParameter(boolvalue):
	animation_tree["parameters/conditions/isHit"] = boolvalue
