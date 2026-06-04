extends Control
@onready var texture_rect: TextureRect = $TextureRect

func workshop_open():
	visible = true
	
func workshop_close():
	visible = false
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
