extends Button
@onready var backgroundsprite: Sprite2D = $background
@onready var container: CenterContainer = $CenterContainer
@onready var inventory = preload("res://inventory/player_inventory.tres")
@onready var itemperm: Label = $"../../labelnode/itemperm"
@onready var itemname: Label = $"../../labelnode/itemname"
@onready var label_3: Label = $"../../labelnode/Label3"
@onready var itemdes: Label = $"../../labelnode/itemdes"
@onready var itemtypeperm: Label = $"../../labelnode/itemtypeperm"
@onready var itemtype: Label = $"../../labelnode/itemtype"
@onready var labelnode: Node2D = $"../../labelnode"

@onready var panel: Panel = $"../../Panel"
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
	if itemStackGui == null :
		return
	
	
	itemdes.visible = true
	itemname.visible = true
	itemtype.visible = true
	itemperm.visible = true
	itemtypeperm.visible = true
	label_3.visible = true
	panel.visible = false
	var item = itemStackGui.inventorySlot.item
	itemname.text = item.name
	itemtype.text = item.item_type
	itemdes.text = item.description
	var label_tween = create_tween()
	label_tween.tween_property(labelnode,"modulate",Color("ffff"),0.2)
	await label_tween.finished
	
	

func _on_mouse_exited() -> void:
	
	await get_tree().create_timer(0.1).timeout
	itemdes.visible = false
	itemname.visible = false
	itemtype.visible = false
	itemperm.visible = false
	itemtypeperm.visible = false
	label_3.visible = false
	panel.visible = true
	var label_tween = create_tween()
	label_tween.tween_property(labelnode,"modulate",Color("0000"),0.2)
	await label_tween.finished
