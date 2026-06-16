extends Panel
@onready var backgroundsprite: Sprite2D = $background
@onready var itemssprite: Sprite2D = $CenterContainer/Panel/items


func update(item: InventoryItem):
	if not item:
		backgroundsprite.visible = false
		itemssprite.visible = false
	else:
		backgroundsprite.visible = true
		itemssprite.visible = true
		itemssprite.texture = item.texture

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
