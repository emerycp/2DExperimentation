extends TileMap

onready var crates = preload("res://Scenes/Crates.tscn")
onready var coins = preload("res://Scenes/Coin.tscn")

func _ready():
	for	tile in get_used_cells():
		if get_cellv(tile) == tile_set.find_tile_by_name("Crate"):
			setObjectOnWorld(crates.instance(), tile)
		elif get_cellv(tile) == tile_set.find_tile_by_name("Coin"):
			setObjectOnWorld(coins.instance(), tile)


func setObjectOnWorld(pObjectInstance, pTile):
	var tilePosition = map_to_world(pTile)
	var object = pObjectInstance
	object.global_position = tilePosition
	get_parent().call_deferred("add_child", object)
	set_cellv(pTile, -1)

