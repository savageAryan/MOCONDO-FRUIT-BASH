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
	get_tree().change_scene_to_file("res://scenes/world.tscn")
	
	


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

@onready var panel: Panel = $Panel
@onready var button: Button = $Button
@onready var button_2: Button = $Button2

func _on_button_2_pressed() -> void:
	panel.visible = true
	animation_player.play("quit pop up")
	mocondo_butterfly.visible = false
	button.visible = false
	button_2.visible = false

func _on_button_2_mouse_entered() -> void:
	point_light_2d_2.visible = true
	point_light_2d_2.energy = 0.5


func _on_button_2_mouse_exited() -> void:
	point_light_2d_2.energy = 0.5
	point_light_2d_2.visible = false


func _on_button_3_pressed() -> void:
	panel.visible = false
	mocondo_butterfly.visible = true
	button.visible = true
	button_2.visible = true


func _on_yesbutton_pressed() -> void:
	get_tree().quit()

@onready var yesbutton: Button = $Panel/Panel/yesbutton
@onready var animation_player_2: AnimationPlayer = $AnimationPlayer2

func _on_yesbutton_mouse_exited() -> void:

	animation_player_2.play("uesbuttonout")


func _on_yesbutton_mouse_entered() -> void:
	
	animation_player_2.play("yesbuttonin")


func _on_button_3_mouse_entered() -> void:
	animation_player_2.play("nobuttonin")


func _on_button_3_mouse_exited() -> void:
	animation_player_2.play("nobuttonout")
