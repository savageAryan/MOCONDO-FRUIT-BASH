extends Node2D
var target: Vector2
@onready var butterflies: Node2D = $butterflies
@onready var animated_sprite_2d: AnimatedSprite2D = $butterflies/butterfly/AnimatedSprite2D
@onready var butterfly: Area2D = $butterfly
var speed:float = 30
func _ready() -> void:
	new_target()
	animated_sprite_2d.play("fly front")
func _physics_process(delta: float) -> void:
	swift_fly(delta)
func new_target():
	var range = randf_range(70,140)
	target = Vector2(randf_range(-range,range),randf_range(-range,range))
func swift_fly(delta):
	for butterfly in butterflies.get_children():
		pass
		
	var direction = (target - global_position).normalized()
	var distance = global_position.direction_to(target)
	global_position = global_position.move_toward(target,speed * delta)
	if direction.length() > 0:
		rotation = direction.angle() + deg_to_rad(90)
	if distance < 5:
		new_target()
