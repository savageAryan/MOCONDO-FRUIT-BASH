extends Area2D

@export var itemRes: InventoryItem
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		GameManager.strawberry += 1
		print(GameManager.strawberry)
		queue_free()
