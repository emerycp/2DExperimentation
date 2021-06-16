extends Area2D

export var value = 1

func _ready():
	get_parent().totalCoins += 1

func _process(delta):
	$Node2D/Coin.rotation_degrees += 250 * delta
	

func _on_Coin_body_entered(pBody):
	if(pBody.name == "Player"):
		pBody.collect_coin(value)
		queue_free()
