extends Control
@onready var point_light_2d_2: PointLight2D = $Button2/Label/PointLight2D_2
@onready var point_light_2d: PointLight2D = $Button/Label/PointLight2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_mouse_entered() -> void:
	point_light_2d.energy = 20

func _on_button_mouse_exited() -> void:
	point_light_2d.energy = 0


func _on_button_2_mouse_entered() -> void:
	point_light_2d_2.energy = 20


func _on_button_2_mouse_exited() -> void:
	point_light_2d_2.energy = 0
