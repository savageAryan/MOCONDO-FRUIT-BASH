extends Area2D
var grow_timer = 20
var grown:bool = false
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
func _ready() -> void:
	crop_grow()
func crop_grow():
	var crop_tween = create_tween()
	crop_tween.tween_property(animated_sprite_2d,"frame",2,10)
	await crop_tween.finished
	grown = true
	print(grown)
