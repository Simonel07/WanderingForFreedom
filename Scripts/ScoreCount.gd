extends Node

export (bool) var buttonVisible

func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	if buttonVisible == 0:
		$UI/Base.visible = 0
	elif buttonVisible == 1:
		$UI/Base.visible = 1
