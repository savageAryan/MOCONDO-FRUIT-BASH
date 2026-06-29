extends Area2D
@export var itemRes: InventoryItem

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		GameManager.wheat += 1
		body.inventory.insert(itemRes)
		queue_free()
