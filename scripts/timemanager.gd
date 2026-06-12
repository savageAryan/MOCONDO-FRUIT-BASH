extends Node2D
var time: float = PI
var time_speed = 0.004

func _process(delta):
	time += delta * time_speed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
