extends Node2D

var nr = 0

onready var g = $Game7
onready var gm = $Game7/BackgroundMusic
onready var gPar = $Game7/ParallaxBackground/ParallaxLayer/Sprite
onready var gPar_2 = $Game7/ParallaxBackground/ParallaxLayer2/Sprite
onready var gPar_3 = $Game7/ParallaxBackground/ParallaxLayer3/Sprite
onready var gPlayer = $Game7/Player
onready var gPage = $Game7/page
onready var gPage_2 = $Game7/page2
onready var gPage_3 = $Game7/page3
onready var p = $Pages
onready var pPage = $Pages/page
onready var pPage_2 = $Pages/page2
onready var pPage_3 = $Pages/page3
onready var s = $Story7

func _ready():
	gm.play()
	g.visible = 0
	p.visible = 0
	gPar.visible = 0
	gPar_2.visible = 0
	gPar_3.visible = 0
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

func _on_Button_pressed():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	g.visible = 1
	gPar.visible = 1
	gPar_2.visible = 1
	gPar_3.visible = 1
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

