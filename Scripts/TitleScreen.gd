extends Node2D

var ok = false

onready var StartButton = $MainMenu/MarginContainer/VBoxContainer/VBoxContainer/StartGame
onready var LevelButton = $MainMenu/MarginContainer/VBoxContainer/VBoxContainer/Levels
onready var CreditButton = $MainMenu/MarginContainer/VBoxContainer/VBoxContainer/Credits
onready var ExitButton = $MainMenu/MarginContainer/VBoxContainer/VBoxContainer/Exit
onready var AnimMenu = $MainMenu/AnimationPlayerMainMenu
onready var BackButton = $Levels/VBoxContainer/VBoxContainer/back
onready var AnimTime = $MainMenu/AnimTime
onready var Level1 = $Levels/VBoxContainer/HBoxContainer/LeftSide/Level1
onready var Level2 = $Levels/VBoxContainer/HBoxContainer/LeftSide/Level2
onready var Level3 = $Levels/VBoxContainer/HBoxContainer/LeftSide/Level3
onready var Level4 = $Levels/VBoxContainer/HBoxContainer/LeftSide/Level4
onready var Level5 = $Levels/VBoxContainer/HBoxContainer/RightSide/Level5
onready var Level6 = $Levels/VBoxContainer/HBoxContainer/RightSide/Level6
onready var Level7 = $Levels/VBoxContainer/HBoxContainer/RightSide/Level7
onready var Level8 = $Levels/VBoxContainer/HBoxContainer/RightSide/Level8

func _ready():
	$MainMenu/BackgroundMusic1.play()
	AnimMenu.play("fade_out")
	AnimMenu.play("StartGame")
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _physics_process(delta):
	if ok == true:
		if StartButton.is_hovered() == true:
			StartButton.grab_focus()
		elif LevelButton.is_hovered() == true:
			LevelButton.grab_focus()
		elif CreditButton.is_hovered() == true:
			CreditButton.grab_focus()
		elif ExitButton.is_hovered() == true:
			ExitButton.grab_focus()

	if Level1.is_hovered() == true:
		Level1.grab_focus()
	elif Level2.is_hovered() == true:
		Level2.grab_focus()
	elif Level3.is_hovered() == true:
		Level3.grab_focus()
	elif Level4.is_hovered() == true:
		Level4.grab_focus()
	elif Level5.is_hovered() == true:
		Level5.grab_focus()
	elif Level6.is_hovered() == true:
		Level6.grab_focus()
	elif Level7.is_hovered() == true:
		Level7.grab_focus()
	elif Level8.is_hovered() == true:
		Level8.grab_focus()
	elif BackButton.is_hovered() == true:
		BackButton.grab_focus()

func _on_StartGame_pressed():
	if ok == true:
		$MainMenu/Click.play()
		$MainMenu/FadeIn.show()
		$MainMenu/FadeIn.fade_in()
		get_tree().change_scene("res://Scenes/Tutorial.tscn")


func _on_Start_pressed():
	if ok == true:
		$MainMenu/Click.play()
		$MainMenu/FadeIn.show()
		$MainMenu/FadeIn.fade_in()
		get_tree().change_scene("res://Scenes/Tutorial.tscn")


func _on_Levels_pressed():
	if ok == true:
		$MainMenu/Click.play()
		$Levels.visible = 1
		$Credits.visible = 0
		$MainMenu.visible = 0
		Level1.grab_focus()

func _on_LevelsT_pressed():
	if ok == true:
		$MainMenu/Click.play()
		$Levels.visible = 1
		$Credits.visible = 0
		$MainMenu.visible = 0
		Level1.grab_focus()

func _on_Credits_pressed():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$MainMenu/Click.play()
	$MainMenu.visible = 0
	$Levels.visible = 0
	$Credits.visible = 1
	$Credits/AnimationPlayer.play("Scroll")
	
func _on_CreditsT_pressed():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$MainMenu/Click.play()
	$MainMenu.visible = 0
	$Levels.visible = 0
	$Credits.visible = 1
	$Credits/AnimationPlayer.play("Scroll")

func _on_Exit_pressed():
	if ok == true:
		$MainMenu/Click.play()
		$MainMenu/Timer.start()

func _on_ExitT_pressed():
	if ok == true:
		$MainMenu/Click.play()
		$MainMenu/Timer.start()


func _on_back_pressed():
	$MainMenu/Click.play()
	$Levels.visible = 0
	$Credits.visible = 0
	$MainMenu.visible = 1


func _on_Level1_pressed():
	$MainMenu/Click.play()
	$MainMenu/FadeIn.show()
	$MainMenu/FadeIn.fade_in()
	get_tree().change_scene("res://Scenes/StageOne.tscn")


func _on_Level2_pressed():
	$MainMenu/Click.play()
	$MainMenu/FadeIn.show()
	$MainMenu/FadeIn.fade_in()
	get_tree().change_scene("res://Scenes/StageTwo.tscn")


func _on_Level3_pressed():
	$MainMenu/Click.play()
	$MainMenu/FadeIn.show()
	$MainMenu/FadeIn.fade_in()
	get_tree().change_scene("res://Scenes/StageThree.tscn")


func _on_Level4_pressed():
	$MainMenu/Click.play()
	$MainMenu/FadeIn.show()
	$MainMenu/FadeIn.fade_in()
	get_tree().change_scene("res://Scenes/StageFour.tscn")


func _on_Level5_pressed():
	$MainMenu/Click.play()
	$MainMenu/FadeIn.show()
	$MainMenu/FadeIn.fade_in()
	get_tree().change_scene("res://Scenes/StageFive.tscn")


func _on_Level6_pressed():
	$MainMenu/Click.play()
	$MainMenu/FadeIn.show()
	$MainMenu/FadeIn.fade_in()
	get_tree().change_scene("res://Scenes/StageSix.tscn")


func _on_Level7_pressed():
	$MainMenu/Click.play()
	$MainMenu/FadeIn.show()
	$MainMenu/FadeIn.fade_in()
	get_tree().change_scene("res://Scenes/StageSeven.tscn")


func _on_Level8_pressed():
	$MainMenu/Click.play()
	$MainMenu/FadeIn.show()
	$MainMenu/FadeIn.fade_in()
	get_tree().change_scene("res://Scenes/StageEight.tscn")


func _on_Timer_timeout():
	get_tree().quit()

func _on_AnimationPlayer_animation_finished(anim_name):
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$Levels.visible = 0
	$Credits.visible = 0
	$MainMenu.visible = 1


func _on_AnimationPlayerMainMenu_animation_finished(anim_name):
	if anim_name == "StartGame":
		LevelButton.rect_scale = Vector2(0,0)
		LevelButton.visible = 1
		AnimMenu.play("Levels")
	if anim_name == "Levels":
		CreditButton.rect_scale = Vector2(0,0)
		CreditButton.visible = 1
		AnimMenu.play("Credits")
	if anim_name == "Credits":
		ExitButton.rect_scale = Vector2(0,0)
		ExitButton.visible = 1
		AnimMenu.play("Exit")
		ok = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		StartButton.grab_focus()
