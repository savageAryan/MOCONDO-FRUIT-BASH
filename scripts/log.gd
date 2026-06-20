extends Area2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var itemRes: InventoryItem
func _ready() -> void:
	animation_player.play("log pop") 
	if randf() < 0.5:
		scale.x *= -1
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.inventory.insert(itemRes)
		GameManager.log += 1
		queue_free()
