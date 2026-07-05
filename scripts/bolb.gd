extends CharacterBody2D
@onready var ui: ui = $"../CanvasLayer/ui"
var speed = 50
@export var player: CharacterBody2D
var chasing = false
var waiting = false

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
	var random_x = randf_range(-100, 100)
	var random_y = randf_range(-100, 100)
	ramdon_target = global_position + Vector2(random_x, random_y)
	navigation_agent_2d.target_position = ramdon_target
func roaming():
	if waiting:
		return
	
	var point_X = navigation_agent_2d.get_next_path_position()
	print(point_X)
	var direction = (point_X - global_position).normalized()
	if abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			animated_sprite_2d.play("side walking")
			animated_sprite_2d.flip_h = true
		else: 
			animated_sprite_2d.play("side walking")
			animated_sprite_2d.flip_h = false
	else:
		if direction.y > 0:
			animated_sprite_2d.play("walking front")
		else:
			animated_sprite_2d.play("back walking")
	velocity = direction * speed
	print(velocity)
	move_and_slide()
	if navigation_agent_2d.navigation_finished:
		velocity = Vector2.ZERO
		waiting = true
		await get_tree().create_timer(3).timeout
		random_Targer()
		waiting = false
		
	
func folloe_player():
	if player == null:
		velocity = Vector2.ZERO
		move_and_slide()
		return
	navigation_agent_2d.target_position = player.global_position
	var point_X = navigation_agent_2d.get_next_path_position()
	var direction = (point_X - global_position).normalized()
	
	velocity = direction * speed
	if abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			animated_sprite_2d.play("side walking")
			animated_sprite_2d.flip_h = true
		else: 
			animated_sprite_2d.play("side walking")
			animated_sprite_2d.flip_h = false
	else:
		if direction.y > 0:
			animated_sprite_2d.play("walking front")
		else:
			animated_sprite_2d.play("back walking")
	
	var distance = global_position.distance_to(player.global_position)
	if distance < 50:
		velocity = Vector2.ZERO
		
		
	move_and_slide()
		
