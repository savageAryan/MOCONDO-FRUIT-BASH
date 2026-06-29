extends Area2D
@export var itemRes: InventoryItem
@onready var tractor: CharacterBody2D = $"../tractor"

signal wheatpicked

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		wheatpicked.emit()
		GameManager.wheat += 1
		body.inventory.insert(itemRes)
		if tractor != null:
			tractor.wheatpicked()
		queue_free()
