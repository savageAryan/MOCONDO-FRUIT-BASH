extends Area2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
func _ready() -> void:
	var animations = ["1","2","3","4"]
	animated_sprite_2d.play(animations.pick_random())
