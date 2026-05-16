extends Area2D

@onready var button: Button = $Button

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		button.visible = true
		
		
	


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/fields.tscn")


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		button.visible = false
