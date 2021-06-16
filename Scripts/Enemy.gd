extends "res://Scripts/BaseEnemy.gd"

export var speed : int = 150
var jumpForce: int = 350

var hitpoint: int = 3
var maxHitpoint: int

var currentTimer: float = 5.0

onready var startX : float = position.x
onready var startY : float = position.y

var raycast: Vector2
var ledgeX: Vector2
var ledgeY: Vector2

var vel = Vector2()
func _ready():
	raycast = $RayCast2D.get_cast_to()
	ledgeX = $LedgeX.get_cast_to()
	ledgeY = $LedgeY.get_cast_to()
	initRandomDirection()

func _process(delta):
	vel.x = 0
	if goingRight:
		vel.x += speed
	else:
		vel.x -= speed

	vel.y += get_parent().gravity * delta
	damageAnimation()

func _physics_process (_delta):
	if $RayCast2D.is_colliding():
		turnAround()

	if $LedgeX.is_colliding() and !$LedgeY.is_colliding():
		jump()
	
	vel = move_and_slide(vel, Vector2.UP)

func jump():
	vel.y -= jumpForce

func initRandomDirection():
	$RayCast2D.set_cast_to(raycast)

	var rng = RandomNumberGenerator.new()
	rng.randomize()
	goingRight = bool(rng.randi_range(0,1))
	hitpoint = rng.randi_range(3,5)
	setHitpoints()

	if !goingRight: # inverse initial
		reverseRaycasts()

func _on_Timer_timeout(): # respawn
	visible = true
	position.x = startX
	position.y = startY
	setHitpoints()
	initRandomDirection()

func showHitpoints():
	if hitpoint <= 0:
		die()

	damageState = true
	$HealthBar.visible = true
	$HealthBar/Hitpoint.text = hitpoint as String + "/" + maxHitpoint as String
	$HealthBar/Hitpoint/HealthTimer.start(0.7)

func setHitpoints():
	maxHitpoint = hitpoint
	
func _on_HealthTimer_timeout():
	$HealthBar.visible = false
	damageState = false

func _on_Enemy_body_entered (pPlayer):
	if pPlayer.name == "Player" and visible:
		if pPlayer.vel.y > 0:
			pPlayer.jump()
			hitpoint -= pPlayer.jumpDamage
			showHitpoints()
		else:
			pPlayer.die()



