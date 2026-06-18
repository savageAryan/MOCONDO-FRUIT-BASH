extends Button
@onready var background_sprite: Sprite2D = $background
@onready var item_stack_gui: ItemStackGui = $CenterContainer/Panel


func update_to_slot(slot: InventorySlot) -> void:
	if not slot.item:
		item_stack_gui.visible = false
		background_sprite.visible = false
		return
		
	item_stack_gui.inventorySlot = slot
	item_stack_gui.update()
	item_stack_gui.visible = true
	
	background_sprite.visible = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
