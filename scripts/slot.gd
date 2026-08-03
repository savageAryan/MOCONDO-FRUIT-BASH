extends Button
class_name InventorySlotButton
signal hovered(item)
signal unhovered()
@onready var backgroundsprite: Sprite2D = $background
@onready var container: CenterContainer = $CenterContainer
@onready var inventory = preload("res://inventory/player_inventory.tres")
@onready var itemperm: Label = $"../../labelnode/itemperm"
@onready var itemname: Label = $"../../labelnode/itemname"
@onready var label_3: Label = $"../../labelnode/Label3"
@onready var itemdes: Label = $"../../labelnode/itemdes"
@onready var itemtypeperm: Label = $"../../labelnode/itemtypeperm"
@onready var itemtype: Label = $"../../labelnode/itemtype"
@onready var labelnode: Control = $"../../labelnode"
var label_tween: Tween
var hovering:bool = false

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

	return item
	
func isEmpty():
	return !itemStackGui

func clear() -> void:
	if itemStackGui:
		container.remove_child(itemStackGui)
		itemStackGui = null
	backgroundsprite.visible = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _on_mouse_entered() -> void:
	if itemStackGui == null:
		return
	hovered.emit(itemStackGui.inventorySlot.item)
func _on_mouse_exited() -> void:
	unhovered.emit()
	
	
