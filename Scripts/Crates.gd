extends KinematicBody2D

onready var chipScene = load("res://Scenes/Chip.tscn")

var vel = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	vel.y += get_parent().gravity * delta
	vel = move_and_slide(vel, Vector2.UP)

func _on_Area_entered(pArea):
	if(pArea.name == "Bullet"):
		pArea.queue_free()
		destroy()

func destroy():
	var chipInstance = chipScene.instance()
	chipInstance.position = position
	chipInstance.emitting = true
	get_parent().add_child(chipInstance)
	queue_free()
