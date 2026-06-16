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
func connectSlots():
	for slot in slots:
		var callable = Callable(onSlotClicked)
		callable = callable.bind(slot)
		slot.pressed.connect(callable)
func onSlotClicked(slot):
	pass
	
