extends Control
@onready var color_rect: ColorRect = $ColorRect
@onready var player: Player = $"../../player"
@onready var label: Label = $Label
@onready var point_light_2d: PointLight2D = $PointLight2D
@onready var button: Button = $Button
func _ready() -> void:
	visible = false


func _on_player_player_dead() -> void:
	visible = true
	var tween = create_tween()
	tween.set_parallel()
	tween.tween_property(color_rect,"modulate",Color("ff030393"), 0.4)
	color_rect.visible = true
	await get_tree().create_timer(4).timeout
	var label_tween = create_tween()
	
	label.visible = true
	label_tween.tween_property(label,"modulate",Color("fff9f7e7"),5)
	await label_tween.finished
	var button_tween = create_tween()
	button.visible = true
	button_2.visible = true
	button_tween.tween_property(button,"modulate",Color("fff"),3)
	button_tween.tween_property(button_2,"modulate",Color("fff"),3)
func _on_button_mouse_entered() -> void:
	point_light_2d.visible = true
	point_light_2d.energy = 0.5
func _on_button_mouse_exited() -> void:
	point_light_2d.energy = 0.5
	point_light_2d.visible = false

@onready var button_2: Button = $Button2

func _on_button_pressed() -> void:
	await get_tree().create_timer(1.2).timeout
	get_tree().change_scene_to_file("res://scenes/world.tscn")

@onready var point_light_2d_2: PointLight2D = $PointLight2D2

func _on_button_2_mouse_entered() -> void:
	point_light_2d_2.visible = true
	point_light_2d_2.energy = 0.5


func _on_button_2_mouse_exited() -> void:
	point_light_2d_2.visible = false
	point_light_2d_2.energy = 0.5


func _on_button_2_pressed() -> void:
	await get_tree().create_timer(1.2).timeout
	get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")
