extends KinematicBody2D

const GRAVITY = 10
const FLOOR = Vector2(0, -1)

export(int) var speed = 30
export(int) var max_health = 100
export(Vector2) var size = Vector2(1, 1)

var velocity = Vector2()
var direction = 1
var is_dead = false
var scorekill = 0
var nr = 0
var speed1 = speed
var attacking = false
var wait = false
var play = preload("res://Scenes/Player.tscn")
var player = play.instance()
var is_in = 0

signal AddScore(scorekill)
signal max_health(max_health)
signal healt_updated(health)
signal killed()
signal number(nr)

onready var health = max_health setget _set_health
onready var invulnerabillity_timer = $InvulnerabillityTimer
onready var anim = $AnimationPlayer
onready var sprite = $AnimatedSprite
onready var see = $Vision/CollisionShape2D
onready var attack = $Attack/CollisionShape2D
onready var damage_anim = $Damage/CollisionShape2D
onready var col = $CollisionShape2D

func _ready():
	scale = size
	pass

func _physics_process(delta):
	if is_dead == false:
		if attacking == false and wait == false:
			velocity.x = speed * direction
			
			if direction == 1:
				sprite.flip_h = false
				see.position = Vector2(40,0)
				attack.position = Vector2(15,-7)
				damage_anim.position = Vector2(9,-7)
				col.position = Vector2(-4,-4)
				$RayCast2D.position = Vector2(7,-1.8)
			else:
				sprite.flip_h = true
				
			sprite.play("walk")
			
			velocity.y += GRAVITY
			
			velocity = move_and_slide(velocity, FLOOR)
			
			if is_on_wall():
				direction = direction * -1
				wait = true
				
			elif $RayCast2D.is_colliding() == false:
				direction = direction * -1
				wait = true
				
		elif attacking == true and wait == false:
			sprite.play("attack")
			velocity.y += GRAVITY
			
			
		elif attacking == false and wait == true:
			sprite.play("idle")
			velocity.y += GRAVITY
	
	if get_slide_count() > 0:
		for i in range(get_slide_count()):
			if "Player" in get_slide_collision(i).collider.name:
				get_slide_collision(i).collider.damage(30)

func _on_Timer_timeout():
	queue_free()
	
func damage(amount):
	if invulnerabillity_timer.is_stopped():
		invulnerabillity_timer.start()
		_set_health(health - amount)
		anim.play("damage")
		anim.queue("flash")

func kill():
	$Damage.queue_free()
	scorekill += 1
	nr += 1
	emit_signal("AddScore", scorekill)
	emit_signal("number", nr)
	is_dead = true
	velocity = Vector2(0, 0)
	$Killed.play()
	sprite.play("dead")
	$CollisionShape2D.set_deferred("disabled", true)
	$Timer.start()
	if scale > Vector2(1, 1):
		get_parent().get_node("ScreenShake").screen_shake(1, 10, 100)

func _set_health(value):
	var prev_health = health
	health = clamp(value, 0, max_health)
	if health != prev_health:
		emit_signal("healt_updated", health)
		if(health == 0):
			kill()


func _on_InvulnerabillityTimer_timeout():
	anim.play("rest")


func _on_Area2D_body_entered(body):
	if "Player" in body.name:
		speed += 20
		is_in = 0


func _on_Area2D_body_exited(body):
	if "Player" in body.name:
		speed -= 20

func _on_Attack_body_entered(body):
	if "Player" in body.name:
		attacking = true

func _on_AnimatedSprite_animation_finished():
	if sprite.animation == "attack":
		attacking = false
	if sprite.animation == "idle":
		wait = false
		see.position.x *= -1
		attack.position.x *= -1
		col.position = Vector2(6.5,-4)
		damage_anim.position = Vector2(-9,-7)
		$RayCast2D.position.x *= -1

func _on_Damage_body_exited(body):
	if "Player" in body.name and sprite.frame >= 4:
		body.damage(10)
	elif "Player" in body.name and is_in == 1:
		body.damage(10)


func _on_Damage_body_entered(body):
	if "Player" in body.name:
		$Damage2.start()


func _on_Damage2_timeout():
	is_in = 1
