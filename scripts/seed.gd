extends Area2D
func _ready() -> void:
	seed_drop()
	despawn()
	await despawn()
func despawn():
	await get_tree().create_timer(63).timeout
	queue_free()

@export var itemRes: InventoryItem
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		GameManager.rootseed += 1
		body.inventory.insert(itemRes)
		queue_free()

func seed_drop():
	var drop_pos = global_position + Vector2(randf_range(-25, 25), randf_range(-25 ,25))
	var seed_tween = create_tween()
	seed_tween.tween_property(self,"global_position",drop_pos, 0.4)
	seed_tween.chain().tween_property(self,"position:y",self.position.y -16, 0.15)
	seed_tween.chain().tween_property(self,"position:y",self.position.y,0.25)
