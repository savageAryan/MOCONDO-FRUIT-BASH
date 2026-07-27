extends Area2D
var grown:bool = false
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var harvest_item: PackedScene
signal harvested(cell:Vector2i)
var cell_pos = Vector2i.ZERO
func _ready() -> void:
	crop_grow()
func crop_grow():
	var crop_tween = create_tween()
	crop_tween.tween_property(animated_sprite_2d,"frame",2,10)
	await crop_tween.finished
	grown = true
func _on_mouse_entered() -> void:
	animated_sprite_2d.position.y -= 1
	animated_sprite_2d.modulate = Color("fbb4c4ff")
func _on_mouse_exited() -> void:
	animated_sprite_2d.position.y += 1
	animated_sprite_2d.modulate = Color("ffffffff")
	
func harvest():
	harvested.emit(cell_pos)
	var crop = harvest_item.instantiate()
	add_sibling(crop)
	crop.global_position = global_position
	queue_free()
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and grown:
			harvest()
