extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0



signal monkey
signal out
func _on_area_2d_body_entered(body: Node2D) -> void:
		if body.is_in_group("player"):
			
			monkey.emit()


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
			
			out.emit()
