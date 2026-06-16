extends Panel
@onready var backgroundsprite: Sprite2D = $background
@onready var itemssprite: Sprite2D = $CenterContainer/Panel/items
@onready var amount_label: Label = $CenterContainer/Panel/amountLabel


func update(slot: InventorySlot):
	if not slot.item:
		backgroundsprite.visible = false
		itemssprite.visible = false
		amount_label.visible = false
	else:
		backgroundsprite.visible = true
		itemssprite.visible = true
		itemssprite.texture = slot.item.texture
		amount_label.visible = true
		amount_label.text = str(slot.amount)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
