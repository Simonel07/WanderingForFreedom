extends Area2D

const SPEED = 120
var velocity = Vector2()
var direction = 1
export (Vector2) var fSize

func _ready():
	scale = fSize

func set_fireball_direction(dir):
	direction = dir
	if dir == -1:
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.flip_h = true

func _physics_process(delta):
	velocity.x = SPEED * delta * direction
	translate(velocity) 
	$AnimatedSprite.play("shoot")

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Fireball_body_entered(body):
	if "Player" in body.name:
		if scale > Vector2(1,1):
			body.damage(50)
		elif scale <= Vector2(1,1):
			body.damage(35)
	queue_free()
