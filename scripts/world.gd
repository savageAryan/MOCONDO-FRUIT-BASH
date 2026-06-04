extends Node2D
@onready var timer: Timer = $Timer



@onready var house: AnimatedSprite2D = $StaticBody2D/house
@onready var button_2: Button = $Button2

@onready var button: Button = $Button
@onready var canvas_modulate: CanvasModulate = $CanvasModulate


@onready var ui: Control = $CanvasLayer/ui



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	canvas_modulate.time_tick.connect(ui.set_daytime)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		house.play("gateopen")
		button.visible = true



func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		house.play("gateclosed")
		button.visible = false


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/home.tscn")


func _on_boatrest_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		button_2.visible = true


func _on_boatrest_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		button_2.visible = false


func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/boat.tscn")





@onready var canvas_layer: CanvasLayer = $CanvasLayer

@onready var workshop: Control = $CanvasLayer/workshop


func _on_workshop_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		
		button_3.visible = true
	
func _on_workshop_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		ui.visible = true
		button_3.visible = false
		workshop.workshop_close()

@onready var button_3: Button = $StaticBody2D3/Button3


func _on_button_3_pressed() -> void:
	workshop.workshop_open()
	ui.visible = false
	button_3.visible = false
