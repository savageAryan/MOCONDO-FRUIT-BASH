extends Control
@onready var texture_rect: TextureRect = $TextureRect
@onready var workshopselectedui: TextureRect = $Control/Workshopselectedui

var selected = null
func workshop_open():
	visible = true
	
func workshop_close():
	visible = false
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false


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
