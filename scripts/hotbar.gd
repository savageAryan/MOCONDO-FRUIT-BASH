extends TextureRect
@onready var inventory: Inventory = preload("res://inventory/player_inventory.tres")
@onready var slots: Array = $Container.get_children()
@onready var selector: Sprite2D = $selector
var currently_selected: int = 0
var scrool = true
func update() -> void:
	for i in range(slots.size()):
		var inventory_slot: InventorySlot = inventory.slots[i]
		slots[i].update_to_slot(inventory_slot)
func move_selector() -> void:
	currently_selected = (currently_selected +1)% slots.size()
	selector.global_position = slots[currently_selected].global_position
func move_selectorback() -> void:
	currently_selected = (currently_selected -1)% slots.size()
	selector.global_position = slots[currently_selected].global_position

func _unhandled_input(event) -> void:
	if event.is_action_pressed("use"):
		inventory.use_Item_at_Index(currently_selected)
	if event is InputEventMouseButton and scrool == true:
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			move_selector()
			scrool = false
			await get_tree().create_timer(0.05).timeout
			scrool = true
	if event is InputEventMouseButton and scrool == true:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			move_selectorback()
			scrool = false
			await get_tree().create_timer(0.05).timeout
			scrool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update()
	inventory.updated.connect(update)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
