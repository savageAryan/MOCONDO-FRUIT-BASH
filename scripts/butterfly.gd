extends Area2D
var speed = 20
enum states{fly,rest}
var state = states.fly
var facing = null
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var target: Vector2
func _ready() -> void:
	new_target()
func _physics_process(delta: float) -> void:
	match state:
		states.fly:
			fly(delta)
		states.rest:
			pass
func new_target():
	var radius = 200
	target = global_position + Vector2(randf_range(-radius,radius),randf_range(-radius,radius))
	
func fly(delta):
	var direction = (target - global_position).normalized()
	var distance = global_position.distance_to(target)
	global_position = global_position.move_toward(target, speed * delta)
	if abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			facing = "side"
			animated_sprite_2d.play("default")
			animated_sprite_2d.flip_h = false
		else:
			facing = "side"
			animated_sprite_2d.play("default")
			animated_sprite_2d.flip_h = true
	else:
		if direction.y > 0:
			facing = "back"
			animated_sprite_2d.play("default")
		else:
			facing = "front"
			animated_sprite_2d.play("default")
	
	if distance < 2:
		state = states.rest
		rest()
func rest():
	animated_sprite_2d.play("rest")
	await get_tree().create_timer(5).timeout
	new_target()
	state = states.fly
	
