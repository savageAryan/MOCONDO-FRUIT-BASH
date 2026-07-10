extends Control
@onready var color_rect: ColorRect = $ColorRect
@onready var player: Player = $"../../player"
@onready var label: Label = $Label
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
