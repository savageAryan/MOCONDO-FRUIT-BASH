extends Area2D
var speed = randf_range(40,70)
enum states{fly,rest,}
var state = states.fly
var facing = null
@onready var flowers: Node2D = $"../../flowers"

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var target: Vector2
var velocity: Vector2
var fixed_pos = null
var t:= 0.0
var wobble_amount := 0
var wobble_time := 0
var wobble_strength = 0.3
var wobble_speed = 8.0
var wobble_timer = 0.0
var flower_target = null
var rest_time := 0.0
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
	var radius = randf_range(80,150)
	target = fixed_pos + Vector2(randf_range(-radius,radius),randf_range(-radius,radius))
	
func fly(delta):
	
	rest_time += delta
	var dir = (target - global_position).normalized()
	var perp = Vector2(-dir.y,dir.x)
	t += delta
	var wobble = sin(t * wobble_time)* wobble_strength + sin(t + 2.3)* 0.15
	var desired = (target - global_position).normalized()
	if randf() < 0.03:
		desired = desired.rotated(randf_range(-0.25,0.25))
	desired += perp * wobble
	desired = desired.normalized()
	velocity = velocity.lerp(desired,0.12)
	velocity += Vector2(randf_range(-0.08,0.08),randf_range(-0.08,0.08))
	velocity = velocity.normalized()
	global_position += velocity * speed * delta
	wobble_timer -= delta
	if wobble_timer < 0:
		speed = randf_range(40,70)
		wobble_timer = randf_range(0.4,0.6)
		wobble_amount = randf_range(3,7)
		wobble_time = randf_range(10,30)
		wobble_strength = randf_range(0.2,0.4)
		wobble_speed = randf_range(1.0, 2.0)
	var direction = (target - global_position).normalized()
	var distance = global_position.distance_to(target)
	if direction.length() > 0:
		rotation = direction.angle() + deg_to_rad(90)
	if abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			facing = "side"
			animated_sprite_2d.play("fly side")
			animated_sprite_2d.flip_h = false
		else:
			facing = "side"
			animated_sprite_2d.play("fly side")
			animated_sprite_2d.flip_h = true
	if abs(direction.y) > abs(direction.x):
		if direction.y > 0:
			facing = "back"
			animated_sprite_2d.play("fly front")
		else:
			facing = "front"
			animated_sprite_2d.play("fly front")
	
	if distance < 2 and flower_target == null:
		new_target()
	if rest_time > 3 and flower_target == null:
		var flower = flowers.get_children().pick_random()
		flower_target = flower.global_position
		target = flower_target
		if flower_target != null and global_position.distance_to(target) < 5:
			rest()
func rest():
	flower_target = null
	velocity = Vector2.ZERO
	rest_time = 0
	state = states.rest
	animated_sprite_2d.play("rest")
	await get_tree().create_timer(7).timeout
	new_target()
	state = states.fly
	
	
