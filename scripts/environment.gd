extends Node2D

@onready var environment: Node2D = $"."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var elements = get_children()
	for element in elements:
		element.frame = randi_range(0,3)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
