class_name capybara extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var player: Player = $"../player"
@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
var ramdon_target = Vector2.ZERO
var facing = "front"
var speed = 20
var waiting:bool = false
var stuck_pos = Vector2.ZERO
var stuck_time = 0.0
var annoyed:bool = false
var chasing:bool =false
var attacking:bool = false
var sleeping:bool = false
func _physics_process(delta: float) -> void:
	roaming()
	if global_position.distance_to(stuck_pos) < 1:
		stuck_time += delta
	else: stuck_time = 0
	stuck_pos = global_position
	if stuck_time > 5.0:
		stuck_time = 0
		random_Targer()
func _ready() -> void:
	random_Targer()
	sleep_cycle()
func random_Targer():

	
	ramdon_target = global_position + Vector2(randf_range(-200,200), randf_range(-200,200))
	navigation_agent_2d.target_position = ramdon_target
func roaming():
	if chasing:
		chasing_player()
		return
	if annoyed:
		attack()
		return
	if attacking:
		return
	if sleeping:
		return
	if waiting:
		play_idel()
		return
	if navigation_agent_2d.is_navigation_finished():
		velocity = Vector2.ZERO
		play_idel()
		move_and_slide()
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
	if velocity.length() < 1:
		play_idel()
	if navigation_agent_2d.is_navigation_finished():
		velocity = Vector2.ZERO
		play_idel()
		waiting = true
		
		await get_tree().create_timer(6).timeout
		random_Targer()
		waiting = false

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
	sleeping = true
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
		sleep()
		await get_tree().create_timer(10).timeout
		sleeping = false
		random_Targer()
		
func chasing_player():
	navigation_agent_2d.target_position = player.global_position
	var next_x = navigation_agent_2d.get_next_path_position()
	var direction = (next_x - global_position).normalized()
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
	velocity = velocity.move_toward(direction * speed ,12)
	move_and_slide()
func attack():
	if attacking:
		return
	attacking = true
	animated_sprite_2d.play("alert front")
	await get_tree().create_timer(3).timeout
	var distance = global_position.distance_to(player.global_position)
	if distance < 60:
		attacking = true
		chasing_player()
	else:
		random_Targer()

func _on_detectarea_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		annoyed = true


func _on_detectarea_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		annoyed = false
