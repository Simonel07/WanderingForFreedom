extends Area2D

export(String, FILE, "*tscn") var target_stage_1
export(String, FILE, "*tscn") var target_stage_2
export(String) var Level_name_1
export(String) var Level_name_2
export(int) var level_nr 
export(int) var Count

func _ready():
	pass

func _on_ChangeStage_body_entered(body):
	if "Player" in body.name:
		if Count >= 1:
			$CanvasLayer/Control2.show()
		elif Count <= 0:
			if level_nr == 1:
				$CanvasLayer/Control/ColorRect/ColorRect/Label.text = Level_name_1
			elif level_nr == 2:
				$CanvasLayer/Control/ColorRect/ColorRect/Label.text = Level_name_2
			$CanvasLayer/Control2.hide()
			$CanvasLayer/Control.show()
			$AnimationPlayer.play("fade_in")
			$ChangeStage.play()


func _on_AnimationPlayer_animation_finished(anim_name):
	if level_nr == 1:
		get_tree().change_scene(target_stage_1)
	elif level_nr == 2:
		get_tree().change_scene(target_stage_2)

func _on_Enemy_number(nr):
	Count = Count - nr


func _on_ChangeStage_body_exited(body):
	$CanvasLayer/Control2.hide()


func _on_Phantom_number(nr):
	Count = Count - nr

func _on_page_Number(n):
	Count = Count - n
