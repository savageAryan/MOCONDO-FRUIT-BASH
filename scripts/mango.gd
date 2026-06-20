extends Area2D
@export var itemRes: InventoryItem

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.inventory.insert(itemRes)
		GameManager.mango += 1
		queue_free()
