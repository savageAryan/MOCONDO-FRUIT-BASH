extends CanvasLayer
@onready var invenrory: Control = $invenrory
@onready var ui: Control = $ui
@onready var player: Player = $"../player"

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Inventory"):
		
		if invenrory.isopen:
			ui.visible = true
			invenrory.close()
		else:
			invenrory.open()
			ui.visible = false



@onready var texture_button = $invenrory/TextureButton

func _on_invenrory_closed() -> void:
	player.can_move = false


func _on_invenrory_opened() -> void:
	player.can_move = true
