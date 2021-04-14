extends Node2D

var nr = 0

onready var g = $Game1
onready var gm = $Game1/BackgroundMusic
onready var gPar = $Game1/ParallaxBackground/ParallaxLayer/Sprite
onready var gPar_2 = $Game1/ParallaxBackground/ParallaxLayer2/Sprite
onready var gPlayer = $Game1/Player
onready var gPage = $Game1/page
onready var p = $Pages
onready var pPage = $Pages/page
onready var s = $Story1
onready var mrc = $Game1/moveRight
onready var mrl = $Game1/moveRight2
onready var mlc = $Game1/moveLeft
onready var mll = $Game1/moveLeft2
onready var mjc = $Game1/jump
onready var mjl = $Game1/jump2
onready var mspc = $Game1/sprint
onready var mspl = $Game1/sprint2
onready var mdac = $Game1/damage
onready var mdal = $Game1/damage2
onready var mwc = $Game1/warning
onready var mwl = $Game1/warning2
onready var msc = $Game1/shoot
onready var msl = $Game1/shoot2
onready var mdjc = $Game1/doubleJump
onready var mdjl = $Game1/doubleJump2
onready var mcc = $Game1/congrats
onready var mcl = $Game1/congrats2
onready var mfc = $Game1/final
onready var mfl = $Game1/final2

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

func _on_moveRight_body_entered(body):
	if "Player" in body.name:
		mrl.visible = 1

func _on_moveRight_body_exited(body):
	if "Player" in body.name:
		mrl.visible = 0


func _on_moveLeft_body_entered(body):
	if "Player" in body.name:
		mll.visible = 1

func _on_moveLeft_body_exited(body):
	if "Player" in body.name:
		mll.visible = 0


func _on_jump_body_entered(body):
	if "Player" in body.name:
		mjl.visible = 1

func _on_jump_body_exited(body):
	if "Player" in body.name:
		mjl.visible = 0


func _on_sprint_body_entered(body):
	if "Player" in body.name:
		mspl.visible = 1

func _on_sprint_body_exited(body):
	if "Player" in body.name:
		mspl.visible = 0


func _on_damage_body_entered(body):
	if "Player" in body.name:
		mdal.visible = 1

func _on_damage_body_exited(body):
	if "Player" in body.name:
		mdal.visible = 0


func _on_warning_body_entered(body):
	if "Player" in body.name:
		mwl.visible = 1

func _on_warning_body_exited(body):
	if "Player" in body.name:
		mwl.visible = 0


func _on_shoot_body_entered(body):
	if "Player" in body.name:
		msl.visible = 1

func _on_shoot_body_exited(body):
	if "Player" in body.name:
		msl.visible = 0


func _on_congrats_body_entered(body):
	if "Player" in body.name:
		mcl.visible = 1

func _on_congrats_body_exited(body):
	if "Player" in body.name:
		mcl.visible = 0


func _on_final_body_entered(body):
	if "Player" in body.name:
		mfl.visible = 1

func _on_final_body_exited(body):
	if "Player" in body.name:
		mfl.visible = 0


func _on_doubleJump_body_entered(body):
	if "Player" in body.name:
		mdjl.visible = 1

func _on_doubleJump_body_exited(body):
	if "Player" in body.name:
		mdjl.visible = 0
