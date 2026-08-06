extends Node2D
var target: Vector2
var offsets = {}
var wobble_times = {}
var target_offsets = {}
var velocity := Vector2.ZERO
var target_time:= 0.0
var timer_formation := 0.0
var follow_speed = {}
@onready var butterflies: Node2D = $butterflies
@onready var animated_sprite_2d: AnimatedSprite2D = $butterflies/butterfly/AnimatedSprite2D
@onready var butterfly: Area2D = $butterfly
var speed:float = 0
func _ready() -> void:
	speed = randf_range(20,30)
	for butterfly in butterflies.get_children():
		var sprite = butterfly.get_node("AnimatedSprite2D")
		sprite.play("fly front")
		sprite.speed_scale = randf_range(0.7,1.3)
		butterfly.scale *= randf_range(0.9,1.15)
		follow_speed[butterfly] = randf_range(3,5)
		offsets[butterfly] = Vector2(randf_range(-20,20),randf_range(-20,20))
		wobble_times[butterfly] = randf() * TAU
		target_offsets[butterfly] = offsets[butterfly]
	new_target()
func _process(delta: float) -> void:
	pass
func _physics_process(delta: float) -> void:
	swift_fly(delta)
func new_target():
	var range = randf_range(120,200)
	target = Vector2(randf_range(-range,range),randf_range(-range,range))
func swift_fly(delta):
	for butterfly in butterflies.get_children():
		
		wobble_times[butterfly] += delta
		var forward = velocity.normalized()
		var right = Vector2(-forward.y,forward.x)
		var wobble = Vector2(sin(wobble_times[butterfly] * 7.5),cos(wobble_times[butterfly] * 9.5)* 5)
		var desired_pos = global_position \
		+ forward * offsets[butterfly].y \
		+ right * offsets[butterfly].x \
		+ wobble
		var move_dir = desired_pos - butterfly.global_position
		if move_dir.length() > 0.1:
			butterfly.rotation = move_dir.angle() + PI/2
		target_time += delta
		offsets[butterfly] = offsets[butterfly].lerp(target_offsets[butterfly],delta * 2)
		butterfly.global_position = butterfly.global_position.lerp(desired_pos,follow_speed[butterfly] * delta)
	var direction = (target - global_position).normalized()
	var distance = global_position.distance_to(target)
	var desired = (target - global_position).normalized()
	velocity = velocity.lerp(desired, 2 * delta)
	velocity = velocity.rotated(randf_range(-0.15,0.15) * delta)
	velocity = velocity.normalized()
	
	timer_formation += delta
	if timer_formation > 2:
		timer_formation = 0
		for butterfly in butterflies.get_children():
			target_offsets[butterfly] = Vector2(randf_range(-40,40),randf_range(-30,30))
	global_position += velocity * speed * delta
	if distance < 40:
		new_target()
