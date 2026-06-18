extends HBoxContainer
@onready var inventory: Inventory = preload("res://inventory/player_inventory.tres")
@onready var slots: Array = get_children()

func update() -> void:
	for i in range(slots.size()):
		var inventory_slot: InventorySlot = inventory.slots[i]
		slots[i].update_to_slot(inventory_slot)
		inventory.updated.connect(update)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
