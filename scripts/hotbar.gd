extends TextureRect
@onready var inventory: Inventory = preload("res://inventory/player_inventory.tres")
@onready var slots: Array = $Container.get_children()
@onready var selector: Sprite2D = $selector
var currently_selected: int = 0
func update() -> void:
	for i in range(slots.size()):
		var inventory_slot: InventorySlot = inventory.slots[i]
		slots[i].update_to_slot(inventory_slot)
func move_selector() -> void:
	currently_selected = (currently_selected +1)% slots.size()
	selector.global_position = slots[currently_selected].global_position

func _unhandled_input(event) -> void:
	if event.is_action_pressed("use"):
		inventory.use_Item_at_Index(currently_selected)
	if Input.is_action_just_pressed("inventory_selection"):
		print("selector")
		move_selector()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update()
	inventory.updated.connect(update)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
