extends TileMap

onready var crates = preload("res://Scenes/Crates.tscn")
onready var coins = preload("res://Scenes/Coin.tscn")

func _ready():
	for	tile in get_used_cells():
		if get_cellv(tile) == tile_set.find_tile_by_name("Crate"):
			setObjectOnWorld(crates.instance(), tile, true)
		elif get_cellv(tile) == tile_set.find_tile_by_name("Coin"):
			setObjectOnWorld(coins.instance(), tile, false)


func setObjectOnWorld(pObjectInstance, pTile, pIsCrate):
	var tilePosition = map_to_world(pTile)
	var object = pObjectInstance
	if pIsCrate:
		tilePosition += Vector2(16, 16)
	object.global_position = tilePosition
	get_parent().call_deferred("add_child", object)
	set_cellv(pTile, -1)

