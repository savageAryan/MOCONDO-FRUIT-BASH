extends Control
@onready var color_rect: ColorRect = $ColorRect
@onready var player: Player = $"../../player"



func _on_player_player_dead() -> void:
	var tween = create_tween()
	tween.set_parallel()
	tween.tween_property(color_rect,"modulate",Color("ff030393"), 0.4)
	color_rect.visible = true
	print("player_dead")
