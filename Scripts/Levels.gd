extends Node2D


func _ready():
	$VBoxContainer/HBoxContainer/VBoxContainer/Level1.grab_focus()

func _physics_process(delta):
	if $VBoxContainer/HBoxContainer/VBoxContainer/Level1.is_hovered() == true:
		$VBoxContainer/HBoxContainer/VBoxContainer/Level1.grab_focus()
	
#	if $VBoxContainer/HBoxContainer/LeftSide/Level2.is_hovered() == true:
#		$VBoxContainer/HBoxContainer/LeftSide/Level3.grab_focus()
	
#	if $VBoxContainer/HBoxContainer/LeftSide/Level4.is_hovered() == true:
#		$VBoxContainer/HBoxContainer/LeftSide/Level4.grab_focus()
	
#	if $VBoxContainer/HBoxContainer/RightSide/Level5.is_hovered() == true:
#		$VBoxContainer/HBoxContainer/RightSide/Level5.grab_focus()
	
#	if $VBoxContainer/HBoxContainer/RightSide/Level6.is_hovered() == true:
#		$VBoxContainer/HBoxContainer/RightSide/Level6.grab_focus()
	
#	if $VBoxContainer/HBoxContainer/RightSide/Level7.is_hovered() == true:
#		$VBoxContainer/HBoxContainer/RightSide/Level7.grab_focus()
	
#	if $VBoxContainer/HBoxContainer/RightSide/Level8.is_hovered() == true:
#		$VBoxContainer/HBoxContainer/RightSide/Level8.grab_focus()
	
	if $VBoxContainer/back.is_hovered() == true:
		$VBoxContainer/back.grab_focus()


func _on_back_pressed():
	$FadeIn.show()
	$FadeIn.fade_in()
	$FadeIn.fade_out()
	visible = 0
