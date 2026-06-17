extends Control
var isopen: bool = false
signal opened
signal closed
@onready var texture_rect: TextureRect = $TextureRect
@onready var hotbar: TextureRect = $hotbar
@onready var inventory: Inventory = preload("res://inventory/player_inventory.tres")
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var slots: Array = $TextureRect/GridContainer.get_children()
@onready var ItemStackGuiClass = preload("res://scenes/itemstack.tscn")
var itemInHand: ItemStackGui
func update():
	for i in range(min(inventory.slots.size(), slots.size())):
		var inventorySlot: InventorySlot = inventory.slots[i]
		if not inventorySlot.item: continue
		
		var itemStackGui: ItemStackGui = slots[i].itemStackGui
		if not itemStackGui:
			itemStackGui = ItemStackGuiClass.instantiate()
			slots[i].insert(itemStackGui)
		itemStackGui.inventorySlot = inventorySlot
		itemStackGui.update()
func open():
	texture_rect.visible = true
	opened.emit()
	isopen = true
	
func close():
	texture_rect.visible = false
	closed.emit()
	
	
	
	isopen = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connectSlots()
	texture_rect.visible = false
	update()
	inventory.updated.connect(update)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func takeItemFromSlot(slot):
	print("taking item")
	itemInHand = slot.takeItem()
	print(itemInHand)
	add_child(itemInHand)

	updateItemInHand()
func insertItemInSlot(slot):
	var item = itemInHand
	
	remove_child(itemInHand)
	itemInHand = null
	slot.insert(item)
func connectSlots():
	for i in range(slots.size()):
		var slot = slots[i]
		slot.index = i
		var callable = Callable(onSlotClicked)
		callable = callable.bind(slot)
		slot.pressed.connect(callable)
func onSlotClicked(slot):
	print(slot.itemStackGui)
	
	if slot.isEmpty():
		if not itemInHand:
			return
		insertItemInSlot(slot)
		return
		
	if  !itemInHand:
		takeItemFromSlot(slot)
		return
	if slot.itemStackGui.inventorySlot.item.name == itemInHand.inventorySlot.item.name:
		stackItems(slot)
		return
	swapItems(slot)
func updateItemInHand():
	if not itemInHand: return
	itemInHand.global_position = get_global_mouse_position() - itemInHand.size/2
	print(itemInHand.global_position)
func _input(event: InputEvent) -> void:
	updateItemInHand()
func swapItems(slot):
	var tempItem = slot.takeItem()
	insertItemInSlot(slot)
	itemInHand = tempItem
	add_child(itemInHand)
	updateItemInHand()
func stackItems(slot):
	var slotItem: ItemStackGui = slot.itemStackGui
	var maxAmount = slotItem.inventorySlot.item.maxAmountPrStack
	var totalAmount = slotItem.inventorySlot.amount + itemInHand.inventorySlot.amount
	if slotItem.inventorySlot.amount == maxAmount:
		swapItems(slot)
		return
	if totalAmount <= maxAmount:
		slotItem.inventorySlot.amount = totalAmount
		remove_child(itemInHand)
		itemInHand = null
	else:
		slotItem.inventorySlot.amount =maxAmount
		itemInHand.inventorySlot.amount = totalAmount - maxAmount
	slotItem.update()
	if itemInHand: itemInHand.update()
