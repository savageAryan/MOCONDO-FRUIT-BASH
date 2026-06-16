extends Panel
class_name ItemStackGui
@onready var itemssprite: Sprite2D = $items
@onready var amount_label: Label = $amountLabel
@onready var background: Sprite2D = $background

func update():
	if not inventorySlot or not inventorySlot.item:
		background.visible = true
		return
	itemssprite.visible = true
	itemssprite.texture = inventorySlot.item.texture
	if inventorySlot.amount > 1:
		amount_label.visible = true
		amount_label.text = str(inventorySlot.amount)
	else:
		amount_label.visible = false
var inventorySlot: InventorySlot


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
