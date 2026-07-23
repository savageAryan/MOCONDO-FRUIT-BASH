extends Control
@onready var label: Label = $Button/Label
@onready var label_2: Label = $Button2/Label2
@onready var point_light_2d: PointLight2D = $Button/Label/PointLight2D
@onready var point_light_2d_2: PointLight2D = $Button2/Label2/PointLight2D_2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_mouse_entered() -> void:
	point_light_2d.energy = 20
	label.position.y -= 6
	label.add_theme_color_override("font_color",Color("fff8f8ff"))

func _on_button_mouse_exited() -> void:
	point_light_2d.energy = 0
	label.position.y += 6
	label.add_theme_color_override("font_color",Color("984e34"))

func _on_button_2_mouse_entered() -> void:
	point_light_2d_2.energy = 20
	label_2.position.y -= 6
	label_2.add_theme_color_override("font_color",Color("fff8f8ff"))
func _on_button_2_mouse_exited() -> void:
	point_light_2d_2.energy = 0
	label_2.position.y += 6
	label_2.add_theme_color_override("font_color",Color("984e34"))
