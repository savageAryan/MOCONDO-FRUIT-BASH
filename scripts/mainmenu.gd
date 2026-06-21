extends Control
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var point_light_2d: PointLight2D = $PointLight2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
@onready var mainmenubutton: Sprite2D = $Mainmenubutton


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_mocondorect_mouse_entered() -> void:
	animation_player.play("moconcorectpressed")


func _on_mocondorect_pressed() -> void:
	animation_player.play("moconcorectpressed")


func _on_button_mouse_entered() -> void:
	point_light_2d.visible = true
	point_light_2d.energy = 0.5
	


func _on_button_pressed() -> void:
	
	pass
	


func _on_button_mouse_exited() -> void:
	
	point_light_2d.energy = 0.5
	point_light_2d.visible = false


func _on_button_button_down() -> void:
	point_light_2d.texture_scale = 1.05
	point_light_2d.visible = true
	point_light_2d.energy = 1


func _on_button_button_up() -> void:
	point_light_2d.visible = true
	point_light_2d.texture_scale = 1
	point_light_2d.energy = 0

	
