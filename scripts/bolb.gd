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
		ui.healthdown(2)
		player = body
		chasing = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		if body == player:
			body = null
			chasing = false

func folloe_player():
	if chasing and player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
		animated_sprite_2d.look_at(player.global_position)
	else: velocity = Vector2.ZERO
	
	move_and_slide()
	
