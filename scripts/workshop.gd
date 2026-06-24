extends Control
@onready var texture_rect: TextureRect = $TextureRect
@onready var workshopselectedui: TextureRect = $Control/Workshopselectedui

var selected = null
@onready var mocondo_butterfly: Sprite2D = $MocondoButterfly
@onready var label: Label = $Label


	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	selected = $TextureRect2/ScrollContainer2/MarginContainer/VBoxContainer/Button2
	texture_rect_2.visible = false
	texture_rect_3.visible = false
	texture_rect_4.visible = false
	texture_rect_5.visible = false
	texture_rect_6.visible = false
	texture_rect_7.visible = false
	texture_rect_8.visible = false
	texture_rect_8.texture_scale / -2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if selected != null:
		workshopselectedui.global_position.y = selected.global_position.y - 50
		
func _physics_process(delta: float) -> void:
	pass
	


@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var ui: Control = $"../ui"
@onready var button_3: Button = $"../../StaticBody2D3/Button3"
@onready var invenrory: Control = $"../invenrory"


func _on_button_pressed() -> void:
	animation_player.play("backbutton")
	await animation_player.animation_finished
	ui.visible = true
	visible = false
	button_3.visible = true
	invenrory.visible = true
	
	
@onready var texture_rect_2: TextureRect = $TextureRect2/ScrollContainer/MarginContainer/HBoxContainer/TextureRect2
@onready var texture_rect_3: TextureRect = $TextureRect2/ScrollContainer/MarginContainer/HBoxContainer/TextureRect3
@onready var texture_rect_4: TextureRect = $TextureRect2/ScrollContainer/MarginContainer/HBoxContainer/TextureRect4
@onready var texture_rect_5: TextureRect = $TextureRect2/ScrollContainer/MarginContainer/HBoxContainer/TextureRect5
@onready var texture_rect_6: TextureRect = $TextureRect2/ScrollContainer/MarginContainer/HBoxContainer/TextureRect6
@onready var texture_rect_7: TextureRect = $TextureRect2/ScrollContainer/MarginContainer/HBoxContainer/TextureRect7
@onready var texture_rect_8: TextureRect = $TextureRect2/ScrollContainer/MarginContainer/HBoxContainer/TextureRect8

func _on_button_2_pressed() -> void:
	selected = $TextureRect2/ScrollContainer2/MarginContainer/VBoxContainer/Button2
	
	texture_rect_2.visible = false
	texture_rect_3.visible = true
	texture_rect_4.visible = true
	texture_rect_5.visible = true
	texture_rect_6.visible = true
	texture_rect_7.visible = true
	texture_rect_8.visible = false
@onready var workshopselectedui_2: Sprite2D = $Workshopselectedui2

func _on_button_3_pressed() -> void:
	selected = $TextureRect2/ScrollContainer2/MarginContainer/VBoxContainer/Button3
	texture_rect_2.visible = true
	texture_rect_3.visible = false
	texture_rect_4.visible = false
	texture_rect_5.visible = false
	texture_rect_6.visible = false
	texture_rect_7.visible = false
	texture_rect_8.visible = false

func _on_button_4_pressed() -> void:
	selected = $TextureRect2/ScrollContainer2/MarginContainer/VBoxContainer/Button4
	texture_rect_2.visible = false
	texture_rect_3.visible = false
	texture_rect_4.visible = false
	texture_rect_5.visible = false
	texture_rect_6.visible = false
	texture_rect_7.visible = false
	texture_rect_8.visible = true

func _on_button_5_pressed() -> void:
	selected = $TextureRect2/ScrollContainer2/MarginContainer/VBoxContainer/Button5
	texture_rect_2.visible = false
	texture_rect_3.visible = false
	texture_rect_4.visible = false
	texture_rect_5.visible = false
	texture_rect_6.visible = false
	texture_rect_7.visible = false
	texture_rect_8.visible = false
