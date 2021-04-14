extends KinematicBody2D

const GRAVITY = 10
const FLOOR = Vector2(0, -1)

export(int) var speed = 30
export(int) var max_health = 100
export(Vector2) var size = Vector2(1, 1)
export(int) var lscale = 1

var velocity = Vector2()
var direction = 1
var is_dead = false
var scorekill = 0
var nr = 0
var speed1 = speed
var attacking = false
var wait = false
var play = preload("res://Scenes/Player.tscn")
var FIREBALL = preload("res://Scenes/EnemyFireball.tscn")
var player = play.instance()

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
onready var col = $CollisionShape2D
onready var damage = $Damage/CollisionShape2D
onready var pos = $Position2D
onready var aud = $AudioStreamPlayer2D
onready var waiting_shoot = $waiting_shoot

func _ready():
	scale = size
	see.scale.x = lscale
	see.position.x = 50*lscale
	damage.position.x = 25*lscale

func _physics_process(delta):
	if is_dead == false:
		if attacking == false and wait == false:
			velocity.x = speed * direction
			
			if direction == 1:
				sprite.flip_h = true
				see.position.y = 2.5
				col.position = Vector2(4,-5)
				damage.position.y = 2.5
				pos.position = Vector2(16,-5.6)
				$RayCast2D.position = Vector2(13,-1.8)
				$HealthBar.rect_position.x = -8
			else:
				sprite.flip_h = false
				
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


func _on_Area2D_body_exited(body):
	if "Player" in body.name:
		speed -= 20


func _on_AnimatedSprite_animation_finished():
	if sprite.animation == "attack":
		attacking = false
	if sprite.animation == "idle":
		wait = false
		see.position.x *= -1
		col.position = Vector2(-2,-5)
		if sign(pos.position.x) == 1:
			pos.position.x *= -1
		damage.position.x *= -1
		$RayCast2D.position.x *= -1
		$HealthBar.rect_position.x = -14

func _on_Damage_body_entered(body):
	if "Player" in body.name:
		attacking = true
		sprite.play("attack")
		waiting_shoot.start()


func _on_waiting_shoot_timeout():
	if is_dead == false:
		var fireball = null
		aud.play()
		fireball = FIREBALL.instance()
		fireball.fSize = size
		if sign(pos.position.x) == 1:
			fireball.set_fireball_direction(1)
		else:
			fireball.set_fireball_direction(-1)
		get_parent().add_child(fireball)
		fireball.position = pos.global_position
