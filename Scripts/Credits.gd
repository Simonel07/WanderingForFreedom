extends Node2D


func _ready():
	$AnimationPlayer.play("type")
	$AudioStreamPlayer.play()



func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "type":
		$AnimationPlayer.play("Scroll")
	if anim_name == "Scroll":
		get_tree().change_scene("res://Scenes/TitleScreen.tscn")


func _on_AudioStreamPlayer_finished():
	$AudioStreamPlayer2.play()


func _on_AudioStreamPlayer2_finished():
	$AudioStreamPlayer3.play()
