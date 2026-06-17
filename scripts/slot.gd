extends Button
@onready var backgroundsprite: Sprite2D = $background
@onready var container: CenterContainer = $CenterContainer
@onready var inventory = preload("res://inventory/player_inventory.tres")
var itemStackGui: ItemStackGui
var index: int

func insert(isg: ItemStackGui):
	itemStackGui = isg
	backgroundsprite.visible = true
	container.add_child(itemStackGui)
	if not itemStackGui.inventorySlot or inventory.slots[index] == itemStackGui.inventorySlot:
		return
	inventory.insertSlot(index, itemStackGui.inventorySlot)
	
func takeItem():
	var item = itemStackGui
	inventory.removeSlot(itemStackGui.inventorySlot)
	container.remove_child(itemStackGui)
	itemStackGui = null
	backgroundsprite.visible = false
	return item
	
func isEmpty():
	return !itemStackGui
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
