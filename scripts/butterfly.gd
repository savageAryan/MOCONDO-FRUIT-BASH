extends Area2D
var speed = randf_range(40,70)
enum states{fly,rest}
var state = states.fly
var facing = null
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var target: Vector2
var fixed_pos = null
var t:= 0.0
var wobble_amount := 0
var wobble_time := 0
var wobble_strength = 0.3
var wobble_speed = 8.0
var wobble_timer = 0.0
func _ready() -> void:
	new_target()
func _physics_process(delta: float) -> void:
	
	match state:
		states.fly:
			fly(delta)
		states.rest:
			pass
func new_target():
	fixed_pos = global_position
	var radius = randf_range(50,70)
	target = fixed_pos + Vector2(randf_range(-radius,radius),randf_range(-radius,radius))
	
func fly(delta):
	if randf() < 0.003:
		target += Vector2(
		randf_range(-50,50),randf_range(-50,50))
	if wobble_timer < 0:
		wobble_timer = randf_range(0.4,1.3)
		wobble_amount = randf_range(3,7)
		wobble_time = randf_range(20,50)
		wobble_strength = randf_range(0.1, 0.6)
		wobble_speed = randf_range(4.0, 12.0)
	var direction = (target - global_position).normalized()
	var distance = global_position.distance_to(target)
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
	t += delta
	var dir = (target - global_position).normalized()
	var perp = Vector2(-dir.y,dir.x)
	var wobble = sin(t * wobble_time)* wobble_strength + sin(t + 2.3)* 0.15
	var move_dir = (dir + perp * wobble).normalized()
	global_position += move_dir * speed * delta
	#animated_sprite_2d.position += dir + perp * randf_range(-5,5)
	if distance < 2:
		state = states.rest
		rest()
func rest():
	animated_sprite_2d.play("rest")
	await get_tree().create_timer(5).timeout
	new_target()
	state = states.fly
	
