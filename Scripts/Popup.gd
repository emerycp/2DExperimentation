extends Popup


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().offset = get_viewport_rect().size / 2
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if get_tree().paused and Input.is_action_just_released("action_one"):
		restart()

func _on_Button_pressed():
	restart()

func restart():
	get_tree().paused = false
	return get_tree().reload_current_scene()
