extends Area2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var itemRes: InventoryItem
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.inventory.insert(itemRes)
		queue_free()
