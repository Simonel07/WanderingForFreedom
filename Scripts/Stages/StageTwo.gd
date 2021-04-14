extends Node2D

var nr = 0

onready var g = $Game2
onready var gm = $Game2/BackgroundMusic
onready var gPar = $Game2/ParallaxBackground/ParallaxLayer/Sprite
onready var gPar_2 = $Game2/ParallaxBackground/ParallaxLayer2/Sprite
onready var gPlayer = $Game2/Player
onready var gPage = $Game2/page
onready var gPage_2 = $Game2/page2
onready var gPage_3 = $Game2/page3
onready var gPage_4 = $Game2/page4
onready var b = $Game2/Bariera
onready var bl = $Game2/Bariera/Label
onready var cs = $Game2/ChangeStage
onready var p = $Pages
onready var pPage = $Pages/page
onready var pPage_2 = $Pages/page2
onready var pPage_3 = $Pages/page3
onready var pPage_4 = $Pages/page4
onready var s = $Story2

func _ready():
	gm.play()
	g.visible = 0
	p.visible = 0
	gPar.visible = 0
	gPar_2.visible = 0
	s.visible = 1
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _physics_process(delta):
	if s.visible == true or p.visible == true:
		gPlayer.visibleButton = 0
	elif s.visible == false or p.visible == false:
		gPlayer.visibleButton = 1

	if gPage.PlayerIn == 1:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		p.position = gPlayer.position
		g.visible = 0
		p.visible = 1
		pPage.visible = 1
		gPlayer.moveSpeed = 1
		gPlayer.jump_force = 1
		nr = 1
	
	if gPage_2.PlayerIn == 1:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		p.position = gPlayer.position
		g.visible = 0
		p.visible = 1
		pPage_2.visible = 1
		gPlayer.moveSpeed = 1
		gPlayer.jump_force = 1
		nr = 2
	
	if gPage_3.PlayerIn == 1:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		p.position = gPlayer.position
		g.visible = 0
		p.visible = 1
		pPage_3.visible = 1
		gPlayer.moveSpeed = 1
		gPlayer.jump_force = 1
		nr = 3
		
	if gPage_4.PlayerIn == 1:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		p.position = gPlayer.position
		g.visible = 0
		p.visible = 1
		pPage_4.visible = 1
		gPlayer.moveSpeed = 1
		gPlayer.jump_force = 1
		nr = 4

func _on_Button_pressed():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	g.visible = 1
	gPar.visible = 1
	gPar_2.visible = 1
	s.visible = 0


func _on_ButtonP_pressed():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	g.visible = 1
	p.visible = 0
	gPlayer.moveSpeed = 70
	gPlayer.jump_force = -250
	
	if nr == 1:
		gPage.visible = 0
		gPage.PlayerIn = 0
		pPage.visible = 0
	if nr == 2:
		gPage_2.visible = 0
		gPage_2.PlayerIn = 0
		pPage_2.visible = 0
	if nr == 3:
		gPage_3.visible = 0
		gPage_3.PlayerIn = 0
		pPage_3.visible = 0
	if nr == 4:
		gPage_4.visible = 0
		gPage_4.PlayerIn = 0
		pPage_4.visible = 0


func _on_Area2D_body_entered(body):
	if "Player" in body.name and cs.level_nr == 0:
		bl.visible = 1
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_Area2D_body_exited(body):
	if "Player" in body.name and cs.level_nr == 0:
		bl.visible = 0
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _on_ButtonL_pressed():
	cs.Count -= 1
	cs.level_nr = 1
	b.queue_free()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
func _on_ButtonL2_pressed():
	cs.Count -= 1
	cs.level_nr = 2
	b.queue_free()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
