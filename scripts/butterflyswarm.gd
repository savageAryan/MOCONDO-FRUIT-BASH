extends Node2D

@onready var butterflies: Node2D = $butterflies

var target = Vector2.ZERO
var velocity = Vector2.RIGHT
var speed = 35.0
var target_speed = 35.0

var turn_speed = 0.5
var formation_timer = 0.0
var direction_timer = 0.0
var offsets = {}
var target_offsets = {}
var wobble_time = {}
var follow_speed = {}
var formation_time = randf_range(5,8)
var pass_player = 0.0
var time_pass = 0.0
var player_pass:bool = false
var next_player_pass = randf_range(8.8,15.0)
func _ready() -> void:
	randomize()
	for butterfly in butterflies.get_children():
		var sprite = butterfly.get_node("AnimatedSprite2D")
		sprite.play("fly front")
		sprite.speed_scale = randf_range(0.7,1.3)
		offsets[butterfly] = Vector2(randf_range(-35,35),randf_range(-20,20))
		target_offsets[butterfly] = offsets[butterfly]
		wobble_time[butterfly] = randf() * TAU
		follow_speed[butterfly] = randf_range(3,5)
	
	new_target()
func _physics_process(delta: float) -> void:
	swift_fly(delta)
	butterfly_fly(delta)
func new_target():
	target = Vector2(randf_range(-1800,1800),randf_range(-1200,1200))
func swift_fly(delta):
	var desired = (target - global_position).normalized()
	speed = lerp(speed,target_speed,1.5*delta)
	var turn_strngth = lerp(1.0,3.5,speed / 40.0)
	velocity = velocity.slerp(desired,turn_strngth * delta)
	velocity = velocity.normalized()
	var turn_amount = abs(velocity.cross(desired))
	if pass_player:
		turn_speed = 95.0
	else:
		target_speed = lerp(90,40,turn_amount)
	speed = lerp(speed,target_speed,delta * 0.8)
	global_position += velocity * speed * delta
	
	if global_position.distance_to(target) < 70:
		if player_pass:
			return
		new_target()
func butterfly_fly(delta):
	time_pass += delta
	pass_player += delta
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
		butterfly.rotation = lerp_angle(butterfly.rotation,angle,6 * delta)
		#target = player.global_position /+ Vector2(randf_range(-450,450),randf_range(-300,300))
		if formation_timer > formation_time:
			formation_timer = 0
			var streach = randf_range(0.6,1.7)
			var formation_angle = randf() * TAU
			var radius = randf_range(10,50)
			var base = Vector2(cos(angle),sin(angle)) * radius
			base.x *= streach
			base.y /= streach
			target_offsets[butterfly] = base
			var fly_1 = butterflies.get_children().pick_random()
			var fly_2 = butterflies.get_children().pick_random()
			var change_pos = target_offsets[fly_1]
			target_offsets[fly_1] = target_offsets[fly_2]
			target_offsets[fly_2] = change_pos
	if pass_player > next_player_pass:
		player_pass = 0
		next_player_pass = randf_range(8.0,15.8)
		
		across_player()
		if time_pass > randf_range(4,8):
			if randf() < 0.02:
				target_speed = randf_range(70,95)
				target_speed = lerp(target_speed,40.0,0.4*delta)
func across_player():
	var player = get_tree().get_first_node_in_group("player")
	print(player)
	pass_player = 0
	var side = 1
	if randf() > 0.5:
		side = -1
	var start =  player.global_position \
	+ Vector2(-side * 1200,randf_range(-350,350))
	var finish = player.global_position \
	+ Vector2(side * 1200,randf_range(-350,350))
	target_speed = 95.0
	global_position = start
	player_pass = true
	target = finish
