extends Node2D
var target: Vector2
var offsets = {}
var wobble_times = {}
@onready var butterflies: Node2D = $butterflies
@onready var animated_sprite_2d: AnimatedSprite2D = $butterflies/butterfly/AnimatedSprite2D
@onready var butterfly: Area2D = $butterfly
var speed:float = 30
func _ready() -> void:
	for butterfly in butterflies.get_children():
		butterfly.get_node("AnimatedSprite2D").play("fly front")
		offsets[butterfly] = Vector2(randf_range(20,20),randf_range(20,20))
		wobble_times[butterfly] = randf() * TAU
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
		var wobble = Vector2(sin(wobble_times[butterfly] * 6),cos(wobble_times[butterfly] * 8)* 4)
		var desired_pos = global_position + offsets[butterfly] + wobble
		butterfly.global_position = butterfly.global_position.move_toward(desired_pos,40 * delta)
	var direction = (target - global_position).normalized()
	var distance = global_position.distance_to(target)
	global_position = global_position.move_toward(target,speed * delta)
	if direction.length() > 0:
		rotation = direction.angle() + deg_to_rad(90)
	if distance < 5:
		new_target()
