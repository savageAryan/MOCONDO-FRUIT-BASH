extends Control
@onready var texture_rect: TextureRect = $TextureRect
@onready var workshopselectedui: TextureRect = $Control/Workshopselectedui

var selected = null

	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	selected = $TextureRect2/ScrollContainer2/MarginContainer/VBoxContainer/Button2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if selected != null:
		workshopselectedui.global_position.y = selected.global_position.y - 50


func _on_button_2_pressed() -> void:
	selected = $TextureRect2/ScrollContainer2/MarginContainer/VBoxContainer/Button2

@onready var workshopselectedui_2: Sprite2D = $Workshopselectedui2

func _on_button_3_pressed() -> void:
	selected = $TextureRect2/ScrollContainer2/MarginContainer/VBoxContainer/Button3

func _on_button_4_pressed() -> void:
	selected = $TextureRect2/ScrollContainer2/MarginContainer/VBoxContainer/Button4


func _on_button_5_pressed() -> void:
	selected = $TextureRect2/ScrollContainer2/MarginContainer/VBoxContainer/Button5

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
	
	
