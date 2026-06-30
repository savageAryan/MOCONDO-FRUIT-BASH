extends Node2D
@onready var button: Button = $Button


func _on_homearea_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		button.visible = true
		


func _on_homearea_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		button.visible = false


func _ready() -> void:
	label.visible = false

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/world.tscn")

@onready var player: Player = $player
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var button_2: Button = $Button2
@onready var panel: Panel = $Panel
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var label: Label = $Label

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		button_2.visible = true

@onready var panel_2: Panel = $Panel2
@onready var panel_3: Panel = $Panel3


func _on_button_2_pressed() -> void:
	player.set_physics_process(false)
	player.visible = false
	animated_sprite_2d.visible = true
	button_2.visible = false
	panel.visible = true
	panel_2.visible = true
	panel_3.visible = true
	
	animation_player.play("new_animation")
	label_appear()
	
	await animation_player.animation_finished
	player.set_physics_process(true)
	player.visible = true
	animated_sprite_2d.visible = false
	button_2.visible = true
	panel.visible = false
	panel_2.visible = false
	panel_3.visible = false
	label.visible = false
	
func label_appear():
	await get_tree().create_timer(5).timeout
	

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		button_2.visible = false
