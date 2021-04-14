extends Control


func _ready():
	$ColorRect.visible = 0
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_VideoPlayer_finished():
	get_tree().change_scene("res://Scenes/TitleScreen.tscn")


func _on_Button_pressed():
	$ColorRect.visible = 1
	$AnimationPlayer.play("skip")


func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene("res://Scenes/TitleScreen.tscn")
