extends Control
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var point_light_2d: PointLight2D = $PointLight2D
@onready var mocondo_butterfly: Sprite2D = $MocondoButterfly



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
@onready var mainmenubutton: Sprite2D = $Mainmenubutton

# Called every frame. 'delta' is the elapsed time since the previous frame.




func _on_mocondorect_mouse_entered() -> void:
	animation_player.play("moconcorectpressed")

@onready var directional_light_2d: DirectionalLight2D = $DirectionalLight2D

func _on_mocondorect_pressed() -> void:
	animation_player.play("moconcorectpressed")
	directional_light_2d.energy = 0.5
	await get_tree().create_timer(0.5).timeout
	directional_light_2d.energy = 0.3
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

	

@onready var point_light_2d_2: PointLight2D = $PointLight2D2

func _on_button_2_button_down() -> void:
	point_light_2d_2.texture_scale = 1.05
	point_light_2d_2.visible = true
	point_light_2d_2.energy = 1


func _on_button_2_button_up() -> void:
	point_light_2d_2.visible = true
	point_light_2d_2.texture_scale = 1
	point_light_2d_2.energy = 0


func _on_button_2_pressed() -> void:
	pass


func _on_button_2_mouse_entered() -> void:
	point_light_2d_2.visible = true
	point_light_2d_2.energy = 0.5


func _on_button_2_mouse_exited() -> void:
	point_light_2d_2.energy = 0.5
	point_light_2d_2.visible = false
