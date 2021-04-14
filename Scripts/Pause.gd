extends Control


func _ready():
	$MarginContainer/CenterContainer/VBoxContainer/TextureButton.grab_focus()
	$MarginContainer/Sprite/AnimationPlayer.play("New Anim (2)")

func _physics_process(delta):
	if $MarginContainer/CenterContainer/VBoxContainer/TextureButton.is_hovered() == true:
		$MarginContainer/CenterContainer/VBoxContainer/TextureButton.grab_focus()
	if $MarginContainer/CenterContainer/VBoxContainer/TextureButton2.is_hovered() == true:
		$MarginContainer/CenterContainer/VBoxContainer/TextureButton2.grab_focus()
	if $MarginContainer/CenterContainer/VBoxContainer/TextureButton3.is_hovered() == true:
		$MarginContainer/CenterContainer/VBoxContainer/TextureButton3.grab_focus()
	if visible == true:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		$MarginContainer/CenterContainer/VBoxContainer/TextureButton.grab_focus()
		var new_pause_state = not get_tree().paused
		get_tree().paused = new_pause_state
		visible = new_pause_state

func _on_TextureButton_pressed():
	$Click.play()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	var new_pause_state = not get_tree().paused
	get_tree().paused = new_pause_state
	visible = new_pause_state

func _on_TextureButton2_pressed():
	$Click.play()
	get_tree().change_scene("res://Scenes/TitleScreen.tscn")
	var new_pause_state = not get_tree().paused
	get_tree().paused = new_pause_state
	visible = new_pause_state


func _on_TextureButton3_pressed():
	$Click.play()
	$Timer.start()


func _on_TouchScreenButton_pressed():
	$Click.play()
	$MarginContainer/CenterContainer/VBoxContainer/TextureButton.grab_focus()
	var new_pause_state = not get_tree().paused
	get_tree().paused = new_pause_state
	visible = new_pause_state


func _on_Continue_pressed():
	$Click.play()
	var new_pause_state = not get_tree().paused
	get_tree().paused = new_pause_state
	visible = new_pause_state


func _on_MainMenu_pressed():
	$Click.play()
	var new_pause_state = not get_tree().paused
	get_tree().paused = new_pause_state
	visible = new_pause_state
	get_tree().change_scene("res://Scenes/TitleScreen.tscn")


func _on_Exit_pressed():
	$Click.play()
	$Timer.start()


func _on_Timer_timeout():
	get_tree().quit()
