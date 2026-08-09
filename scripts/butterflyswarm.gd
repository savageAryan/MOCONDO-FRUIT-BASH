extends Node2D

@onready var butterflies: Node2D = $butterflies

var target = Vector2.ZERO
var velocity = Vector2.RIGHT
var speed = 35.0
var target_speed = 35.0


var formation_timer = 0.0
var direction_timer = 0.0
var offsets = {}
var target_offsets = {}
var wobble_time = {}
var follow_speed = {}
var formation_time = randf_range(5,8)
var pass_player = 0.0
var next_player_pass:= 0.0
var looping:bool = false
var time_pass = 0.0
var loop_time := 0.0
var loop_duration = 0
var loop_radius =0
var loop_direction = 0
var player_pass:bool = false
var pass_target = Vector2.ZERO
var after_passtarget = Vector2.ZERO
var special_timer := 0.0
@onready var world: Node2D = $".."
@onready var flowers: Node2D = $"../flowers"
var next_move_pass = randf_range(8.8,15.0)
func _ready() -> void:
	randomize()
	for butterfly in butterflies.get_children():
		var sprite = butterfly.get_node("AnimatedSprite2D")
		
		sprite.play("fly front")
		print(world.routine)
		sprite.speed_scale = randf_range(0.7,1.3)
		sprite.scale *= randf_range(0.8,1.6)
		
		
		offsets[butterfly] = Vector2(randf_range(-65,65),randf_range(-60,60))
		target_offsets[butterfly] = offsets[butterfly]
		wobble_time[butterfly] = randf() * TAU
		follow_speed[butterfly] = randf_range(3,5)
	new_target()
func _physics_process(delta: float) -> void:
	special_timer += delta
	if player_pass:
		across_player(delta)
	elif looping:
		fly_loop(delta)
	else:
		swift_fly(delta)
		butterfly_fly(delta)
	if special_timer >= next_move_pass and !player_pass and !looping:
		special_timer = 0 
		next_move_pass = randf_range(8.8,15.0)
		if randf() < 0.7:
			player_across()
		else:
			loop()
func new_target():
	target = flowers.get_children().pick_random().global_position
func swift_fly(delta):
	var desired = (target - global_position).normalized()
	speed = lerp(speed,target_speed,1.5*delta)
	var turn_strngth = lerp(1.0,3.5,speed / 40.0)
	velocity = velocity.slerp(desired,turn_strngth * delta)
	velocity = velocity.normalized()
	var turn_amount = abs(velocity.cross(desired))
	if player_pass:
		target_speed = 95.0
	else:
		target_speed = lerp(90,40,turn_amount)
	speed = lerp(speed,target_speed,delta * 0.8)
	global_position += velocity * speed * delta
	
	if global_position.distance_to(target) < 12:
		if player_pass:
			player_pass = false
			return
		new_target()
func butterfly_fly(delta):
	pass_player += delta
	time_pass += delta
	formation_timer += delta
	for butterfly in butterflies.get_children():
		wobble_time[butterfly]+=delta
		var forward = velocity
		var player = get_tree().get_first_node_in_group("player")
		var right = Vector2(-forward.y,forward.x)
		var wobble = right * sin(wobble_time[butterfly] * 8)*4 + forward * sin(wobble_time[butterfly] * 4) *2
		offsets[butterfly] = offsets[butterfly].lerp(target_offsets[butterfly],delta)
		var desired = global_position + right*offsets[butterfly].x + forward*offsets[butterfly].y + wobble
		
		butterfly.global_position = butterfly.global_position.lerp(desired,follow_speed[butterfly] * delta)
		var angle = velocity.angle() + PI/2
		butterfly.rotation = lerp_angle(butterfly.rotation,angle,8.0 * delta)
		#target = player.global_position /+ Vector2(randf_range(-450,450),randf_range(-300,300))
		if formation_timer > formation_time:
			formation_timer = 0
			var streach = randf_range(0.6,1.7)
			var formation_angle = randf() * TAU
			var radius = randf_range(10,50)
			var base = Vector2(cos(formation_angle),sin(formation_angle)) * radius
			base.x *= streach
			base.y /= streach
			target_offsets[butterfly] = base
			var fly_1 = butterflies.get_children().pick_random()
			var fly_2 = butterflies.get_children().pick_random()
			var change_pos = target_offsets[fly_1]
			target_offsets[fly_1] = target_offsets[fly_2]
			target_offsets[fly_2] = change_pos
		if time_pass > randf_range(4,8):
			if randf() < 0.02:
				target_speed = randf_range(70,95)
				target_speed = lerp(target_speed,40.0,0.4*delta)
func across_player(delta):
	var desired: Vector2
	if player_pass_stage == 0:
		desired = (target - global_position.normalized())
		if global_position.distance_to(target) < 30:
			player_pass_stage = 1
	elif player_pass_stage == 1:
		desired = (pass_target - global_position).normalized()
		if global_position.distance_to(pass_target) < 30:
			player_pass_stage = 2
	else:
		desired = (after_passtarget - global_position).normalized()
		if global_position.distance_to(after_passtarget) < 40:
			player_pass = false
			player_pass_stage = 0
			target_speed = randf_range(45,60)
			new_target()
			return
	velocity = velocity.slerp(desired, 1.5 * delta).normalized()
	target_speed = 85.0
	speed = lerp(speed,target_speed,1.5 *delta)
	global_position += velocity * speed * delta
	
func fly_loop(delta):
	loop_time += delta
	var progress = loop_time / loop_duration
	var angular_speed = TAU / loop_duration
	var angle = progress* TAU * loop_direction
	var desired_direction = Vector2(cos(angle),sin(angle))
	var tangent = Vector2(-sin(angle)*loop_direction,cos(angle)* loop_direction)
	velocity = velocity.slerp(tangent.normalized(),2.5*delta)
	velocity = velocity.normalized()
	var loop_speed = 55.5
	speed = lerp(speed,loop_speed,1.5 * delta)
	global_position += velocity * speed * delta
	if loop_time > loop_duration:
		looping = false
		loop_time = 0.0
		target_speed = randf_range(35,50)
		new_target()
var player_pass_stage := 0
func player_across():
	var player = get_tree().get_first_node_in_group("player")
	if player == null:
		return
	var player_pos = player.global_position
	player_pass = true
	player_pass_stage = 0
	var side := 1.0
	if randf() < 0.5:
		side = -1
	var height_offset = randf_range(-120,120)
	var start = player_pos + Vector2(side * 650, height_offset)
	pass_target = player_pos + Vector2(-side * randf_range(20,80), height_offset * 0.5)
	after_passtarget = player_pos + Vector2(-side * 700,height_offset)
	target = start
func loop():
	looping = true
	loop_time = 0.0
	loop_duration = randf_range(2.5,4)
	
	if randf() < 0.5:
		loop_direction = 1.0
	else:
		loop_direction = -1.0
func light_update():
	for butterfly in butterflies.get_children():
		var sprite = butterfly.get_node("AnimatedSprite2D")
		var light = sprite.get_node("PointLight2D")
		var light_tween = create_tween()
		var light_energy = 0
		if world.routine == "morning":
			light_energy = randf_range(0.09,0.3)
			light_tween.tween_property(light,"energy",light_energy,1.3)
		if world.routine == "evening" or world.routine == "midnight" or world.routine == "night":
			light_energy = randf_range(1.1,1.6)
			light_tween.tween_property(light,"energy",light_energy,1.3)
		else:
			light_energy = 0
			light_tween.tween_property(light,"energy",light_energy,1.3)
