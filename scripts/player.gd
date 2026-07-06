extends CharacterBody2D
class_name Player
var fruits = 10
var current_dir = "none"
var speed = 50

#@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var inventory: Inventory

func _ready() -> void:
	print("player", inventory)
	inventory.use_item.connect(use_item)
	if fruits <= 0 :
		animated_sprite_2d.play("empty idel")
	elif fruits > 0 :
		animated_sprite_2d.play("idel front")
		
func _unhandled_input(event: InputEvent) -> void:
		if Input.is_action_just_pressed("hit"):
			hit_enemy()
			return
func _physics_process(delta: float) -> void:
	if using_tool:
		return
	if Input.is_action_pressed("use"):
		var item = get_selected_item()
		if item and item.item_type == "axe":
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
			
var using_tool = false
func chop():
	using_tool = true
	if fruits <= 0:
		animated_sprite_2d.play("axeside")
	else:
		animated_sprite_2d.play("axeside")
	await animated_sprite_2d.animation_finished
	using_tool = false
func hit_enemy():
	using_tool = true
	animated_sprite_2d.play("swordslash")
	await animated_sprite_2d.animation_finished
	using_tool = false
func use_item(item: InventoryItem) -> void:
	item.use(self)
func get_selected_item() -> InventoryItem:
	return inventory.slots[inventory.selected_index].item
func increase_health(amount: int):
	ui.healthup(amount)
func decrease_health(amount: int):
	ui.healthdown(amount)
@onready var ui: ui = $"../CanvasLayer/ui"
