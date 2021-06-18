extends TileMap

onready var crates = preload("res://Scenes/Crates.tscn")
onready var coins = preload("res://Scenes/Coin.tscn")

func _ready():
	var instance = null
	
	for	tile in get_used_cells():
		var offset = null
		var currentTile = get_cellv(tile)
		match(currentTile):
			0: # Crate
				instance = crates.instance()
				offset = Vector2(16, 16)
			2: # Coin
				instance = coins.instance()
			_: # Anything else
				instance = null
		setObjectOnWorld(instance, tile, offset)


func setObjectOnWorld(pObjectInstance, pTile, pOffset):
	
	if pObjectInstance == null:
		return
		
	var tilePosition = map_to_world(pTile)
	var object = pObjectInstance
	if pOffset != null: # Applies offset
		tilePosition += pOffset
	object.global_position = tilePosition
	set_cellv(pTile, -1)
	get_parent().call_deferred("add_child", object)
	

