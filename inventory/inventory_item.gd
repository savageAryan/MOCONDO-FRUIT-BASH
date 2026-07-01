extends Resource
class_name InventoryItem
@export var name: String = ""
@export var texture: Texture2D
@export var maxAmountPrStack: int
@export var buy_price : int
@export var sell_price : int
@export var item_consumable:bool
@export var item_type: String
func use(player: Player) -> void:
	pass
