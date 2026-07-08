class_name blob extends CharacterBody2D
@onready var ui: ui = $"../CanvasLayer/ui"
@onready var world: Node2D = $".."

var speed = 40
@export var player: CharacterBody2D
var chasing: bool = false
var waiting: bool = false
var knocked:bool = false
var attacking: bool = false
var blob_health = 5
var max_health = 5
var facing = "front"
var stuck_pos = Vector2.ZERO
var stuck_time = 0.0
var deaddd:bool = false
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hearts: Control = $hearts
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
func heart_anim():
	var hp = blob_health
	for heart in hearts.get_children():
		if hp >= 2:
			heart.play("full")
			hp -= 2
		elif hp == 1:
			heart.play("half")
		else: heart.play("empty")
func blob_healthdown(amount, pos):
	var knockback = (global_position - pos).normalized()
	velocity = knockback * 180
	chasing = false
	knocked = true
	blob_health = max(0 ,blob_health - amount)
	heart_anim()
	animation_player.play("damage/hearts animation")
	if blob_health <= 0:
		deaddd = true
		world.blob_spawn()
		await blob_dying()
		return
	await  get_tree().create_timer(0.6).timeout
	chasing = true
	knocked = false
func blob_healthup(amount):
	blob_health = min(max_health, blob_health + amount)
	heart_anim()
	animation_player.play("damage/hearts animation")

var ramdon_target = Vector2.ZERO
func _ready() -> void:
	random_Targer()
	heart_anim()
func _physics_process(delta: float) -> void:
	if deaddd:
		return
	if knocked:
		move_and_slide()
		velocity = velocity.move_toward(Vector2.ZERO, 800 * delta)
		if velocity.length() < 5:
			velocity = Vector2.ZERO
			chasing = true
			knocked = false
		return
	if attacking:
		return
	if global_position.distance_to(stuck_pos) < 1:
		stuck_time += delta
	else: stuck_time = 0
	stuck_pos = global_position
	if stuck_time > 5.0:
		stuck_time = 0
		if chasing:
			navigation_agent_2d.target_position = player.global_position
		else:
			random_Targer()
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
	if velocity.length() < 1:
		play_idel()
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
	if player.global_position.distance_to(navigation_agent_2d.target_position) > 35:
		navigation_agent_2d.target_position = player.global_position
	var point_X = navigation_agent_2d.get_next_path_position()
	var direction = (point_X - global_position).normalized()
	var distance = global_position.distance_to(player.global_position)
	if distance < 15:
		if attacking:
			return
		
			
		velocity = Vector2.ZERO
		attacking = true
		play_idel()
		
		await get_tree().create_timer(0.5).timeout
		if player == null:
			attacking = false
			return
		distance = global_position.distance_to(player.global_position)
		if distance > 40:
			attacking = false
			return
		await attack()
		attacking = false
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
	if velocity.length() < 1:
		if facing == "front":
			animated_sprite_2d.play("idel")
		elif facing == "back":
			animated_sprite_2d.play("back idel")
		else:
			if facing == "side":
				animated_sprite_2d.play("side idel")
func attack():
	
	attacking = true
	if facing == "front":
		animated_sprite_2d.play("jump attack")
	elif facing == "side":
		animated_sprite_2d.play("side attack")
	elif facing == "back":
		animated_sprite_2d.play("back attack")
	
	await animated_sprite_2d.animation_finished
	
	if player == null:
		return
	if player !=null and global_position.distance_to(player.global_position) < 30:
		player.decrease_health(2)
func blob_dying():
	attacking = false
	chasing = false
	knocked = true
	animated_sprite_2d.stop()
	
	if player.current_dir == "left" or "down":
		animated_sprite_2d.play("die")
		animated_sprite_2d.flip_h = true
	if player.current_dir == "right" or "up":
		animated_sprite_2d.play("die")
		animated_sprite_2d.flip_h = false
		
	await animated_sprite_2d.animation_finished
	queue_free()
