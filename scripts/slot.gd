extends Button
@onready var backgroundsprite: Sprite2D = $background
@onready var container: CenterContainer = $CenterContainer
var itemStackGui: ItemStackGui

func insert(isg: ItemStackGui):
	itemStackGui = isg
	backgroundsprite.visible = true
	container.add_child(itemStackGui)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
