extends Area2D

var n = 0
export (float) var PlayerIn = 0
var player = preload("res://Scenes/Player.tscn")
signal Number(n)

func _ready():
	pass


func _on_coin_body_entered(body):
	if "Player" in body.name:
		PlayerIn = 1


func _on_page_visibility_changed():
	if visible == false:
		n += 1
		emit_signal("Number", n)
		$CollisionShape2D.queue_free()
