extends KinematicBody2D

var score = 0
var movement = Vector2();
var on_ground
var k = null
var out_ground = null
var j = null
var i = null
var is_dead = false
var is_attacking = false
var fireball_power = 1
var too_high = false
var too_too_high = false

export (int) var moveSpeed = 70
export (int) var jump_force = -250
export (float) var max_health = 100
export (int) var visibleButton
export (int) var vision = 1605
export(String, FILE, "*tscn") var target_stage

signal max_health(max_health)
signal healt_updated(health)
signal killed()

onready var SAVE_KEY : String = "player_"
onready var health = max_health setget _set_health
onready var invulnerabillity_timer = $InvulnerabillityTimer
onready var damage_anim = $AnimationPlayer


const gravity = 10
const FLOOR = Vector2(0,-1)

const FIREBALL = preload("res://Scenes/Fireball.tscn")
const FIREBALEPOWERED = preload("res://Scenes/FireballPowered.tscn")
const FIREBALEBLUE = preload("res://Scenes/FireballBlue.tscn")
const FIREBALEGREEN = preload("res://Scenes/FireballGreen.tscn")

func _ready():
	set_physics_process(true)
	set_process(true)
	$Camera2D.limit_right = vision

func _process(delta):
	var LabelNode = get_node("ScoreCount/UI/Base/RichTextLabel")
	LabelNode.text = str(score)


func _physics_process(delta):
	$ScoreCount.buttonVisible = visibleButton
	if visibleButton == 0:
		$CanvasLayer3/jump.visible = 0
		$CanvasLayer3/right.visible = 0
		$CanvasLayer3/left.visible = 0
		$CanvasLayer3/Pause.visible = 0
		$CanvasLayer3/Shoot2.visible = 0
		$CanvasLayer3/sprint.visible = 0
	elif visibleButton == 0:
		$CanvasLayer3/jump.visible = 1
		$CanvasLayer3/right.visible = 1
		$CanvasLayer3/left.visible = 1
		$CanvasLayer3/Pause.visible = 1
		$CanvasLayer3/Shoot2.visible = 1
		$CanvasLayer3/sprint.visible = 1
	if is_dead == false:
		if position.y > 1000:
			kill()
		if Input.is_action_pressed("moveRight"):
			if is_attacking == false:
				j = true
				movement.x = moveSpeed
				$AnimatedSprite.play("run")
				$AnimatedSprite.flip_h = false
				$CollisionShape2D.position = Vector2(-3.165, 2.317)
				if sign($Position2D.position.x) == -1:
					$Position2D.position.x *= -1
				if Input.is_action_pressed("sprint") && j == true:
					movement.x = moveSpeed * 2
					$AnimatedSprite.play("run")
					$AnimatedSprite.flip_h = false
					$CollisionShape2D.position = Vector2(-3.165, 2.317)
					if sign($Position2D.position.x) == -1:
						$Position2D.position.x *= -1
		elif Input.is_action_pressed("moveLeft"):
			if is_attacking == false:
				j = true
				movement.x = -moveSpeed
				$AnimatedSprite.play("run")
				$AnimatedSprite.flip_h = true
				$CollisionShape2D.position = Vector2(0,2.4)
				if sign($Position2D.position.x) == 1:
					$Position2D.position.x *= -1
				if Input.is_action_pressed("sprint") && j == true:
					movement.x = -moveSpeed * 2
					$AnimatedSprite.play("run")
					$AnimatedSprite.flip_h = true
					if sign($Position2D.position.x) == 1:
						$Position2D.position.x *= -1
		else:
			j = false
			movement.x = 0
			if on_ground == true && is_attacking == false:
				$AnimatedSprite.play("Idle")
		
		
		if Input.is_action_just_pressed("jump"):
			if is_attacking == false:
				if on_ground == true:
					$Jump.play()
					movement.y = jump_force
					on_ground = false
					k = true
				elif on_ground == false and out_ground == true:
					$Jump.play()
					movement.y = jump_force
					on_ground = false
					k = true
					out_ground = false
			
		if Input.is_action_just_pressed("shoot") && is_attacking == false:
			is_attacking = true
			var fireball = null
			$Shoot.play()
			$AnimatedSprite.play("attack")
			if fireball_power == 1:
				fireball = FIREBALL.instance()
			elif fireball_power == 2:
				fireball = FIREBALEPOWERED.instance()
			elif fireball_power == 3:
				fireball = FIREBALEBLUE.instance()
			elif fireball_power == 4:
				fireball = FIREBALEGREEN.instance()
			if sign($Position2D.position.x) == 1:
				fireball.set_fireball_direction(1)
			else:
				fireball.set_fireball_direction(-1)
			get_parent().add_child(fireball)
			fireball.position = $Position2D.global_position
		elif Input.is_action_just_released("shoot"): 
			is_attacking = false
		
		movement.y += gravity
		
		if is_on_floor():
			on_ground = true
			out_ground = true
		else:
			on_ground = false
			if is_attacking == false:
				if Input.is_action_just_pressed("jump") && k == true:
					movement.y = jump_force
					k = false
					$Jump.play()
					if movement.y < 0:
						$AnimatedSprite.play("jump")
					else:
						$AnimatedSprite.play("fall")
				if movement.y < 0:
					$AnimatedSprite.play("jump")
				else:
					$AnimatedSprite.play("fall") 
		if Input.is_action_pressed("save"):
			$CanvasLayer2/DebugInterface.show()
		
		
		if movement.y > 450:
			too_high = true
		if movement.y > 700:
			too_too_high = true
		if too_high == true and on_ground == true:
			damage(10)
			too_high = false
		if too_too_high == true and on_ground == true:
			damage(50)
			too_too_high = false
		
		movement = move_and_slide(movement, FLOOR)
		
		if get_slide_count():
			for i in range(get_slide_count()):
				if "Enemy" in get_slide_collision(i).collider.name:
					damage(30)
		if get_slide_count():
			for i in range(get_slide_count()):
				if "Snake" in get_slide_collision(i).collider.name:
					damage(50)
					if invulnerabillity_timer.is_stopped():
						invulnerabillity_timer.start()
						damage_anim.play("Poison")
						damage_anim.queue("flash")
	if is_dead == true:
		movement.y += gravity
		movement = move_and_slide(movement, FLOOR)

func _on_jump_pressed():
	if is_attacking == false:
		if on_ground == true:
			$Jump.play()
			movement.y = jump_force
			on_ground = false
			k = true
		elif on_ground == false and out_ground == true:
			$Jump.play()
			movement.y = jump_force
			on_ground = false
			k = true
			out_ground = false
	if is_on_floor():
			on_ground = true
			out_ground = true
	else:
		on_ground = false
		if is_attacking == false:
			if k == true:
				movement.y = jump_force
				k = false
				$Jump.play()
				if movement.y < 0:
					$AnimatedSprite.play("jump")
				else:
					$AnimatedSprite.play("fall")
			if movement.y < 0:
				$AnimatedSprite.play("jump")
			else:
				$AnimatedSprite.play("fall") 


func _on_right_pressed():
	if is_dead == false:
		if is_attacking == false:
			j = true
			movement.x = moveSpeed
			$AnimatedSprite.play("run")
			$AnimatedSprite.flip_h = false
			$CollisionShape2D.position = Vector2(-3.165, 2.317)
			if sign($Position2D.position.x) == -1:
				$Position2D.position.x *= -1
			#if j == true:
			#	movement.x = moveSpeed * 2
			#	$AnimatedSprite.play("run")
			#	$AnimatedSprite.flip_h = false
			#	if sign($Position2D.position.x) == -1:
			#		$Position2D.position.x *= -1


func _on_left_pressed():
	if is_attacking == false:
		j = true
		movement.x = -moveSpeed
		$AnimatedSprite.play("run")
		$AnimatedSprite.flip_h = true
		$CollisionShape2D.position = Vector2(0,2.4)
		if sign($Position2D.position.x) == 1:
			$Position2D.position.x *= -1
		if Input.is_action_pressed("sprint") && j == true:
			movement.x = -moveSpeed * 2
			$AnimatedSprite.play("run")
			$AnimatedSprite.flip_h = true
			if sign($Position2D.position.x) == 1:
				$Position2D.position.x *= -1

func _on_Shoot2_pressed():
	is_attacking = true
	var fireball = null
	$Shoot.play()
	$AnimatedSprite.play("attack")
	if fireball_power == 1:
		fireball = FIREBALL.instance()
	elif fireball_power == 2:
		fireball = FIREBALEPOWERED.instance()
	elif fireball_power == 3:
		fireball = FIREBALEBLUE.instance()
	elif fireball_power == 4:
		fireball = FIREBALEGREEN.instance()
	if sign($Position2D.position.x) == 1:
		fireball.set_fireball_direction(1)
	else:
		fireball.set_fireball_direction(-1)
	get_parent().add_child(fireball)
	fireball.position = $Position2D.global_position

func _on_Shoot2_released():
	is_attacking = false

func _on_Timer_timeout():
	get_tree().change_scene(target_stage)

func book_power_up():
	fireball_power = 2

func book_power_up2():
	fireball_power = 3

func book_power_up3():
	fireball_power = 4

func damage(amount):
	if is_dead == false:
		if invulnerabillity_timer.is_stopped():
			invulnerabillity_timer.start()
			$Damage.play()
			_set_health(health - amount)
			damage_anim.play("damage")
			damage_anim.queue("flash")
		if score > 0:
			if amount > 24:
				score -= 1
			elif amount <= 24 and amount > 0:
				score -= 0.5

func kill():
	is_dead = true
	$Die.play()
	movement = Vector2(0,0)
	$CanvasLayer/GameOver.show()
	$CanvasLayer/GameOver.fade_in()
	$AnimatedSprite.play("dead")
	$Timer.start()

func _set_health(value):
	var prev_health = health
	health = clamp(value, 0, max_health)
	if health != prev_health:
		emit_signal("healt_updated", health)
		if(health == 0):
			kill()


func _on_InvulnerabillityTimer_timeout():
	damage_anim.play("rest")


func _on_coin_body_entered(body):
	if "Player" in body.name:
		pass

func _on_Enemy_AddScore(scorekill):
	score += scorekill


func _on_VisibilityNotifier2D_screen_exited():
	#damage(101)
	pass

func _on_Heart_body_entered(body):
	if health < 100:
		_set_health(health+25)


func _on_GameOver_fade_finished():
	get_tree().change_scene(target_stage)

func save(save_game : Resource):
	save_game.data[SAVE_KEY] = score

func load(save_game : Resource):
	score = save_game.data[SAVE_KEY]


func _on_Phantom_AddScore(scorekill):
	score += scorekill


func _on_page_body_entered(body):
	if "Player" in body.name:
		score += 1
		$Collect.play()
