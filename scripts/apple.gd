extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var itemRes: InventoryItem
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		GameManager.apple += 1
		body.inventory.insert(itemRes)
		print (GameManager.apple)
		queue_free()
