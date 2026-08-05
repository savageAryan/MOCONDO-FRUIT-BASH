extends Area2D
var speed = randf_range(40,70)
enum states{fly,rest,}
var state = states.fly
var facing = null
@onready var flowers: Node2D = $"../../flowers"
var next_rest_time = randf_range(5.0,12.0)
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
var sit_time:= 0.0
var wobble_flower := 0.0
var y_axis_wobble := 0.0

var bara_rest:bool = false
func _ready() -> void:
	new_target()
func _physics_process(delta: float) -> void:
	
	match state:
		states.fly:
			fly(delta)
		states.rest:
			rest(delta)
func new_target():
	fixed_pos = global_position
	var radius = randf_range(80,150)
	target = fixed_pos + Vector2(randf_range(-radius,radius),randf_range(-radius,radius))
	
func fly(delta):
	
	y_axis_wobble += delta
	if y_axis_wobble > 1:
		global_position += Vector2(0,randf_range(-5,5))
		y_axis_wobble = 0
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
	if flower_target == null:
		velocity += Vector2(randf_range(-0.08,0.08),randf_range(-0.08,0.08))
	if flower_target != null:
		velocity += Vector2(randf_range(-0.02,0.02),randf_range(-0.02,0.02))
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
	if rest_time > next_rest_time and flower_target == null:
		var flower = flowers.get_children().pick_random()
		flower_target = flower.global_position
		target = flower_target
		
	if flower_target != null and global_position.distance_to(target) < 5:
		
		wobble_flower += delta
		if wobble_flower > 1.1:
			state = states.rest
			wobble_flower = 0
			return
	var closest: capybara = null
	var closest_distance = INF
	for capy: capybara in get_tree().get_nodes_in_group("capybara"):
		var capy_distance = global_position.distance_to(capy.global_position)
		if capy.sleeping and capy_distance < closest_distance:
			closest = capy
			closest_distance = capy_distance
	if closest and closest_distance < 80:
		target = closest.global_position
	if closest and closest.sleeping and global_position.distance_to(closest.global_position) < 4:
		bara_rest = true
		global_position = closest.global_position - Vector2(0,randf_range(-3,3))
		closest_sleep = closest
		state = states.rest
		return
var closest_sleep = null
func rest(delta):
	sit_time += delta
	velocity = Vector2.ZERO
	state = states.rest
	if bara_rest:
		animated_sprite_2d.play("bara rest")
	else:
		animated_sprite_2d.play("rest")
	if sit_time > 7:
		sit_time = 0
		flower_target = null
		new_target()
		state = states.fly
	if closest_sleep != null:
		if sit_time > 7 or !closest_sleep.sleeping:
			sit_time = 0
			new_target()
			bara_rest = false
			state = states.fly
	
	
	
