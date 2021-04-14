extends Node2D


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _on_Timer1_timeout():
	$AnimationPlayer1.play("fade_out")

func _on_Timer2_timeout():
	$AnimationPlayer2.play("fade_out")

func _on_Timer3_timeout():
	$AnimationPlayer.play("fade_in")



func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene("res://Scenes/Trailer.tscn")
	$Timer3.queue_free()

func _on_AnimationPlayer1_animation_finished(anim_name):
	$ProcyonGaming.visible = 0
	$Present.visible = 1
	$Timer2.start()
	$AnimationPlayer1.stop()

func _on_AnimationPlayer2_animation_finished(anim_name):
	$Present.visible = 0
	$InCautareaLibertatii.visible = 1
	$Timer3.start()
	$AnimationPlayer2.stop()
