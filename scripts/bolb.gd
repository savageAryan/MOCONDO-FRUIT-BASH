extends CharacterBody2D
@onready var ui: ui = $"../CanvasLayer/ui"
var speed = 50
@export var player: CharacterBody2D
var chasing = false
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
func _physics_process(delta: float) -> void:
	folloe_player()
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		
		player = body
		chasing = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		if body == player:
			player = null
			chasing = false


func folloe_player():
	if player == null:
		velocity = Vector2.ZERO
		move_and_slide()
		return
	var direction = (player.global_position - global_position).normalized()
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
	if distance < 40:
		velocity = Vector2.ZERO
		
	move_and_slide()
		
