extends KinematicBody2D

onready var bloodScene = load("res://Scenes/Blood.tscn")

var damageState: bool
var goingRight: bool


func _ready():
	pass # Replace with function body.

func die():
	var bloodInstance = bloodScene.instance()
	bloodInstance.position = position
	bloodInstance.emitting = true
	get_parent().add_child(bloodInstance)
	visible = false
	$Timer.start(5.0)

func damageAnimation():
	if damageState:
		if Engine.get_frames_drawn() % 2 == 0:
			$Sprite.modulate.a = 0.5
		else: 
			$Sprite.modulate.a = 1.0
	else:
		$Sprite.modulate.a = 1.0

# turn the enemy around
func turnAround():
	reverseRaycasts()
	goingRight = !goingRight

func reverseRaycasts():
	$RayCast2D.set_cast_to(-$RayCast2D.get_cast_to())
	$LedgeX.set_cast_to(-$LedgeX.get_cast_to())
	$LedgeY.set_cast_to(-$LedgeY.get_cast_to())
