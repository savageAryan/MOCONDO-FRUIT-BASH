extends Area2D
func _ready() -> void:
	despawn()
	await despawn()
func despawn():
	await get_tree().create_timer(13).timeout
	queue_free()
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var itemRes: InventoryItem
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		GameManager.banana += 1
		body.inventory.insert(itemRes)
		queue_free()
	if body.is_in_group("enemy"):
		queue_free()
