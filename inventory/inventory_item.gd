extends Resource
class_name InventoryItem
@export var name: String = ""
@export var texture: Texture2D
@export var maxAmountPrStack: int
@export var buy_price : int
@export var sell_price : int


func use(player: Player) -> void:
	pass
