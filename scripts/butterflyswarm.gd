extends Node2D
var target: Vector2
var offsets = {}
var wobble_times = {}
var target_offsets = {}
var velocity := Vector2.ZERO
var target_time:= 0.0
var timer_formation := 0.0
var follow_speed = {}
var target_speed = 30.0
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
	target = Vector2(randf_range(-600,600),randf_range(-400,400))
	if randf() < 0.25:
		target = Vector2(randf_range(-1800,1800),randf_range(-1200,1200))
func swift_fly(delta):
	for butterfly in butterflies.get_children():
		
		wobble_times[butterfly] += delta
		speed = lerp(speed,target_speed,delta)
		var forward = velocity.normalized()
		var right = Vector2(-forward.y,forward.x)
		var wobble =right * sin(wobble_times[butterfly]*8.5)*4 \
		+ forward * sin(wobble_times[butterfly]*3.2)*2
		var desired_pos = global_position \
		+ forward * offsets[butterfly].y \
		+ right * offsets[butterfly].x \
		+ wobble
		var move_dir = desired_pos - butterfly.global_position
		if move_dir.length() > 0.1:
			var desired_angle = move_dir.angle() + PI/2
			butterfly.rotation = lerp_angle(butterfly.rotation,desired_angle,6.0 * delta)
		target_time += delta
		offsets[butterfly] = offsets[butterfly].lerp(target_offsets[butterfly],delta * 2)
		butterfly.global_position = butterfly.global_position.lerp(desired_pos,follow_speed[butterfly] * delta)
	var direction = (target - global_position).normalized()
	var distance = global_position.distance_to(target)
	var desired = (target - global_position).normalized()
	velocity = velocity.lerp(desired, 2 * delta)
	var heading_noise = sin(Time.get_ticks_msec()/350.0) * 0.08
	velocity = velocity.rotated(sin(target_time * 0.8) * 0.04 * delta)
	if velocity.length() > 1:
		velocity = velocity.normalized()
	
	timer_formation += delta
	if timer_formation > 5:
		timer_formation = 0
		var stretch = randf_range(0.4,1.8)
		target_speed = randf_range(23,35)
		for butterfly in butterflies.get_children():
			var base = Vector2(randf_range(-40,40),randf_range(-25,25))
			base.x *= stretch
			base.y /= stretch
			target_offsets[butterfly] = base
	global_position += velocity * speed * delta
	if distance < 40:
		new_target()
