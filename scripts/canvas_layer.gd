extends CanvasLayer
@onready var invenrory: Control = $invenrory
@onready var ui: Control = $ui
@onready var player: Player = $"../player"

func  _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Inventory"):
		
		if invenrory.isopen:
			ui.visible = true
			invenrory.close()
			
		else:
			invenrory.open()
			ui.visible = false
			



@onready var texture_button = $invenrory/TextureButton
