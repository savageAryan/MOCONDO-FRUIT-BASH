extends Control
@onready var label: Label = $Panel/Button/Label
@onready var point_light_2d: PointLight2D = $Panel/Button/Label/PointLight2D
@onready var label_2: Label = $Panel/Button2/Label2
@onready var point_light_2d_2: PointLight2D = $Panel/Button2/Label2/PointLight2D_2
@onready var panel: Panel = $Panel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func pop_in():
	var show_tween = create_tween()
	show_tween.tween_property(panel,"modulate",Color("fff"),4)
	#show_tween.tween_property(panel,"position.y",0,0.2)
func pop_out():
	var hide_tween = create_tween()
	hide_tween.tween_property(panel,"modulate",Color("0000"),4)
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
