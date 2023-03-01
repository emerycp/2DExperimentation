extends Node2D

var gravity: int = 800

var totalCoins: int = 0

onready var enemyScene = load("res://Scenes/Enemy.tscn")

# Declare member variables here. Examples:
signal isSliding(pIsOnTile)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_Player_collided(collision):
	if collision.collider is TileMap:
		var tile_pos = collision.collider.world_to_map(collision.collider.to_local($Player.position))
		tile_pos -= collision.normal
		var tile = collision.collider.get_cellv(tile_pos)

		if tile == 0: # if sliding
			emit_signal('isSliding', true)
		else:
			emit_signal('isSliding', false)
