extends CharacterBody2D
@onready var ui: ui = $"../CanvasLayer/ui"
var speed = 50
@export var player: CharacterBody2D
var chasing = false
var waiting = false
var facing = "front"
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D


var ramdon_target = Vector2.ZERO
func _ready() -> void:
	random_Targer()
func _physics_process(delta: float) -> void:
	
	if chasing == true:
		folloe_player()
		
	else:
		if chasing == false:
			roaming()
			
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		
		player = body
		chasing = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		if body == player:
			player = null
			chasing = false

func random_Targer():

	
	ramdon_target = global_position + Vector2(randf_range(-200,200), randf_range(-200,200))
	navigation_agent_2d.target_position = ramdon_target
func roaming():
	if chasing:
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
			animated_sprite_2d.play("side walking")
			animated_sprite_2d.flip_h = true
		else: 
			facing = "side"
			animated_sprite_2d.play("side walking")
			animated_sprite_2d.flip_h = false
	else:
		facing = "front"
		if direction.y > 0:
			animated_sprite_2d.play("walking front")
		else:
			facing = "back"
			animated_sprite_2d.play("back walking")
	velocity = velocity.move_toward(direction * speed, 6)
	
	move_and_slide()
	if navigation_agent_2d.is_navigation_finished():
		velocity = Vector2.ZERO
		play_idel()
		waiting = true
		await get_tree().create_timer(3).timeout
		random_Targer()
		waiting = false
		
	
func folloe_player():
	if player == null:
		velocity = Vector2.ZERO
		move_and_slide()
		return
	if player.global_position.distance_to(navigation_agent_2d.target_position) > 24:
		navigation_agent_2d.target_position = player.global_position
	var point_X = navigation_agent_2d.get_next_path_position()
	var direction = (point_X - global_position).normalized()
	var distance = global_position.distance_to(player.global_position)
	if distance < 32:
		get_tree().create_timer(2).timeout
		velocity = Vector2.ZERO
		
		play_idel()
		return
		
	else:
		velocity = velocity.move_toward(direction * speed,8)
		
		
	move_and_slide()
		
	
	if abs(direction.x) > abs(direction.y) and velocity != Vector2.ZERO:
		if direction.x > 0:
			facing = "side"
			animated_sprite_2d.play("side walking")
			animated_sprite_2d.flip_h = true
		else: 
			facing = "side"
			animated_sprite_2d.play("side walking")
			animated_sprite_2d.flip_h = false
	else:
		if direction.y > 0:
			facing = "front"
			animated_sprite_2d.play("walking front")
		else:
			facing = "back"
			animated_sprite_2d.play("back walking")
	
	

func play_idel():
	if velocity.length() < 1 or waiting:
		if facing == "front":
			animated_sprite_2d.play("idel")
		elif facing == "back":
			animated_sprite_2d.play("back idel")
		else:
			if facing == "side":
				animated_sprite_2d.play("side idel")
