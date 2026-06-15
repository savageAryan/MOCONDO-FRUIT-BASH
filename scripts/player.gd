extends CharacterBody2D
var fruits = 10
var current_dir = "none"
const speed = 50
#@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var inventory: Inventory
func _ready() -> void:
	
	if fruits <= 0 :
		animated_sprite_2d.play("empty idel")
	elif fruits > 0 :
		animated_sprite_2d.play("idel front")
		
func _physics_process(delta: float) -> void:
	if chopping:
		return
		
	if Input.is_action_pressed("BREAK"):
		chop()
		return
	player_movement(delta)
	
	
	
func player_movement(delta):
	
	if Input.is_action_pressed("right"):
		current_dir = "right"
		play_anim(1)
		
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("left"):
		current_dir = "left"
		play_anim(1)
		velocity.x = -speed
		velocity.y =0
	elif Input.is_action_pressed("forward"):
		current_dir = "down"
		play_anim(1)
		velocity.x = 0
		velocity.y = speed
	elif Input.is_action_pressed("backward"):
		current_dir = "up"
		play_anim(1)
		velocity.x = 0
		velocity.y = -speed
	else:
		play_anim(0)
		velocity.x = 0
		velocity.y = 0
		
	move_and_slide()
	
func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	
		
	
	if fruits <= 0:
		
		if dir == 'right':
			anim.flip_h = false
			if movement == 1:
				anim.play('empty side walking')
			else:
				anim.play('empty side idel')
				
		if dir == 'left':
			anim.flip_h = true
			if movement == 1:
				anim.play("empty side walking")
			else:
				anim.play("empty side idel")
				
		if dir == "up":
			if movement == 1:
				anim.play("walking back")
			else:
				anim.play("back idel")
				
		if dir == "down":
			if movement == 1:
				anim.play("empty front walking")
			elif movement == 0:
				anim.play("empty idel")
			
				
		return
			
	
	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play('walking side')
		elif movement == 0:
			anim.play('idel side')
	if dir == 'left':
		anim.flip_h = true
		if movement == 1:
			anim.play('walking side')
		elif movement == 0:
			anim.play("idel side")
	if dir == "down":
		if movement == 1:
			anim.play("walking front")
		elif movement == 0:
			anim.play("idel front")
	if dir == "up":
		if movement == 1:
			anim.play("walking back")
		elif movement == 0:
			anim.play("back idel")
			
var chopping = false
func chop():
	chopping = true
	if fruits <= 0:
		animated_sprite_2d.play("axeside")
	else:
		animated_sprite_2d.play("axeside")
	await animated_sprite_2d.animation_finished
	chopping = false
