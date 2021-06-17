extends KinematicBody2D


var score: int = 0

var speed: int = 200
var jumpForce: int = -350
var slidingForce: int = 150

var vel: Vector2 = Vector2()
var grounded: bool = false


var isMoving: bool = false;
var facingLeft: bool = false
var isSliding: bool = false;

var jumpDamage: int = 1

signal collided(value)

# init
onready var sprite = $AnimatedSprite
onready var ui = get_node("/root/Main/UI/UI")
onready var bulletScene = load("res://Scenes/Bullet.tscn")
onready var enemyScene = load("res://Scenes/Enemy.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if !isSliding:
		vel.x = 0

	if Input.is_action_pressed("move_left"):
		vel.x -= speed
		facingLeft = true
	if Input.is_action_pressed("move_right"):
		vel.x += speed
		facingLeft = false
	if Input.is_action_just_pressed("action_two"):
		initBullet()
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision:
			emit_signal('collided', collision)
		
	$AnimatedSprite.flip_h = facingLeft

	vel.y += get_parent().gravity * delta

	if isSliding:
		var decelerateOnIce
		if is_on_floor():
			decelerateOnIce = slidingForce * delta
		else:
			decelerateOnIce = slidingForce * delta * 0.4

		if vel.x > 0:
			vel.x -= decelerateOnIce
			if vel.x < 0:
				vel.x = 0
				isSliding = false
		elif vel.x < 0:
			vel.x += decelerateOnIce
			if vel.x > 0:
				vel.x = 0
				isSliding = false

		
	if abs(vel.x) >= speed:
		vel.x = sign(vel.x) * speed

	if is_on_floor() and vel.x != 0:
		# sprite.play("move")
		isMoving = true

	if is_on_floor() and vel.x == 0:
		sprite.play("default")
		isMoving = false

	if Input.is_action_just_pressed("action_one") and is_on_floor():
		jump()

	vel = move_and_slide(vel, Vector2.UP)
	

func collect_coin (value):
	score += value
	ui.set_score_text(score)	

	if(score == get_parent().totalCoins):
		showPopup("win!")

func jump():
	vel.y = jumpForce
	# sprite.play("jump")

func die ():
	showPopup("Game over!")

func showPopup(pText):
	$"../Popup/Popup".show()
	$"../Popup/Popup/Label".text = pText
	get_tree().paused = true

func _on_Main_isSliding(pIsOnTile):
	isSliding = isMoving and pIsOnTile

func initBullet():
	var bullet = bulletScene.instance()

	bullet.goingLeft = facingLeft
	bullet.position.x = position.x
	bullet.position.y = position.y

	get_parent().add_child(bullet)


