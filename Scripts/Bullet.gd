extends Area2D

var bulletSpeed: int = 425
var goingLeft: bool = false
var spread: float = 0
var bulletDamage: int = 1

func _ready():
	spread = (randf() -0.5) * 100

func _process(delta):
	if goingLeft:
		rotation_degrees -= 350 * delta
	else:
		rotation_degrees += 350 * delta

func _physics_process(delta):
	if goingLeft:
		position.x -= bulletSpeed * delta
	else:
		position.x += bulletSpeed * delta
	
	position.y += spread * delta

func _on_Bullet_body_entered(pBody):
	if pBody.visible:
		if pBody.name.begins_with("Enemy"):
			pBody.hitpoint -= bulletDamage
			pBody.showHitpoints()
		queue_free()
		
	


	
