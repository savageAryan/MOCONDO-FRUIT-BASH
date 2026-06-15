extends CanvasLayer
@onready var invenrory: Control = $invenrory
@onready var ui: Control = $ui

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Inventory"):
		if invenrory.isopen:
			ui.visible = true
			invenrory.close()
		else:
			invenrory.open()
			ui.visible = false


func _on_invenrory_closed() -> void:
	get_tree().paused = false


func _on_invenrory_opened() -> void:
	get_tree().paused = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
