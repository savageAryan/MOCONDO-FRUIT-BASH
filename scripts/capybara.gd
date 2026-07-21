class_name capybara extends CharacterBody2D
@onready var animated_sprite_2d_2: AnimatedSprite2D = $AnimatedSprite2D2
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var player: Player = $"../player"
@onready var dialouge: Control = $"../CanvasLayer/dialouge"
@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
var ramdon_target = Vector2.ZERO
var facing = "front"
var speed = 20
var stuck_pos = Vector2.ZERO
var stuck_time = 0.0
enum states {wait,sleep,chase,alert,attack,roam,idel}
var state = states.roam
var talked = false
signal capybara_in
signal capybara_out
func _physics_process(delta: float) -> void:
	if global_position.distance_to(stuck_pos) < 1:
		stuck_time += delta
	else: 
		stuck_time = 0
		stuck_pos = global_position
	if stuck_time > 5.0:
		stuck_time = 0
		random_Targer()
	match state:
		states.roam:
			roaming()
		states.chase:
			chasing_player()
		states.sleep:
			sleep()
		states.wait:
			pass
		states.attack:
			pass
		states.alert:
			pass
func _ready() -> void:
	random_Targer()
	sleep_cycle()
func random_Targer():
	ramdon_target = global_position + Vector2(randf_range(-200,200), randf_range(-200,200))
	navigation_agent_2d.target_position = ramdon_target
func roaming():
	if navigation_agent_2d.is_navigation_finished():
		velocity = Vector2.ZERO
		move_and_slide()
		state = states.wait
		wait_finished()
		return
	var point_X = navigation_agent_2d.get_next_path_position()
	
	var direction = (point_X - global_position).normalized()
	if abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			facing = "side"
			animated_sprite_2d.play("bara side walking")
			animated_sprite_2d.flip_h = true
		else: 
			facing = "side"
			animated_sprite_2d.play("bara side walking")
			animated_sprite_2d.flip_h = false
	else:
		facing = "front"
		if direction.y > 0:
			animated_sprite_2d.play("bara front walking")
		else:
			facing = "back"
			animated_sprite_2d.play("bara back walking")
	velocity = velocity.move_toward(direction * speed, 6)
	
	move_and_slide()
func wait_finished():
	state = states.wait
	velocity = Vector2.ZERO
	play_idel()
	await get_tree().create_timer(5).timeout
	random_Targer()
	state = states.roam
func play_idel():
	if velocity.length() < 1:
		if facing == "front":
			animated_sprite_2d.play("bara idel")
		elif facing == "back":
			animated_sprite_2d.play("bara back idel")
		else:
			if facing == "side":
				animated_sprite_2d.play("bara front idel")
				
func sleep():
	velocity = Vector2.ZERO
	if facing == "front":
		animated_sprite_2d.play("sleeping front")
	elif facing == "back":
		animated_sprite_2d.play("sleeping back")
	elif facing == "side":
		animated_sprite_2d.play("sleeping front")
func sleep_cycle():
	while true:
		await get_tree().create_timer(20).timeout
		if state != states.roam:
			continue
		state = states.sleep
		await get_tree().create_timer(10).timeout
		if state == states.sleep:
			random_Targer()
			state = states.roam
func chasing_player():
	if player == null:
		state = states.roam
		return
	navigation_agent_2d.target_position = player.global_position
	var next_x = navigation_agent_2d.get_next_path_position()
	var direction = (next_x - global_position).normalized()
	var distance = global_position.distance_to(player.global_position)
	if distance > 105:
		state = states.roam
		random_Targer()
		return
	if distance < 15:
		state = states.attack
		attack()
		return
	if abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			facing = "side"
			animated_sprite_2d.play("chasing side")
			animated_sprite_2d.flip_h = true
		else:
			facing = "side"
			animated_sprite_2d.play("chasing side")
			animated_sprite_2d.flip_h = false
	else:
		if direction.y > 0:
			facing = "front"
			animated_sprite_2d.play("chasing front")
		else: 
			facing = "back"
			animated_sprite_2d.play("chasing back")
	velocity = velocity.move_toward(direction * speed * 1.5 ,12)
	move_and_slide()
func got_annoyed():
	state = states.alert
	animated_sprite_2d.play("alert front")
	await animated_sprite_2d.animation_finished
	state = states.chase
func attack():
	var knockback = (player.global_position - global_position).normalized()
	state = states.attack
	if facing == "front":
		animated_sprite_2d.play("attack front")
	elif facing == "side":
		animated_sprite_2d.play("attack side")
	else:
		animated_sprite_2d.play("attack back")
	await get_tree().create_timer(0.45).timeout
	if player and global_position.distance_to(player.global_position) < 15:
		player.knockback = (player.global_position - global_position).normalized() * 150
		player.decrease_health(3)
	
	
	if player == null:
		state = states.roam
		return
	await animated_sprite_2d.animation_finished
	if player == null:
		return
	print("Distance after attack:", global_position.distance_to(player.global_position))
	if global_position.distance_to(player.global_position) < 105:
		state = states.chase
	else:
		state = states.roam
func _on_detectarea_body_entered(body: Node2D) -> void:
		if body.is_in_group("player"):
			if not talked and state == states.roam:
				capybara_in.emit()
				dialouge.start_dialogue([
					"Wth! who's This now?",
					"Why are you standing on
					two legs??!",
					"Your Forelimbs are Weird",
					"WHATEVER!!",
					"nnn..Don't Try To Disturb When
					When I am Sleeping"
				],"---CAPYBARA",animated_sprite_2d_2.sprite_frames,"talk",self)
				state = states.idel
				animated_sprite_2d.play("bara idel")
				return
			if state == states.sleep:
				got_annoyed()
func _on_detectarea_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		capybara_out.emit()
		if talked == false and state == states.idel:
			state = states.roam
			random_Targer()
			
func dialouge_finished():
	talked = true
	state = states.roam
