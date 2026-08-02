extends Area2D
var speed = 20
enum states{fly,rest}
var state = states.fly
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var target: Vector2
func _ready() -> void:
	new_target()
func _physics_process(delta: float) -> void:
	match state:
		states.fly:
			fly(delta)
func new_target():
	var radius = 200
	target = global_position + Vector2(randf_range(-radius,radius),randf_range(-radius,radius))
	
func fly(delta):
	var direction = (target - global_position).normalized()
	var distance = global_position.distance_to(target)
	global_position = global_position.move_toward(target, speed * delta)
	
