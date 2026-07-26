extends CharacterBody2D
class_name Player
var fruits = 10
var current_dir = "none"
var speed = 50
var dying:bool = false
var knockback = Vector2.ZERO
#@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var inventory: Inventory
@onready var world: Node2D = $".."


func _ready() -> void:
	inventory.use_item.connect(use_item)
	if fruits <= 0 :
		animated_sprite_2d.play("empty idel")
	elif fruits > 0 :
		animated_sprite_2d.play("idel front")
		
func _unhandled_input(event: InputEvent) -> void:
	if using_tool:
		return
	if Input.is_action_just_pressed("hit"):
		var item = get_selected_item()
		if item and item.item_type == "weapon":
			hit_enemy()
			return
	if Input.is_action_just_pressed("hit"):
		var  item = get_selected_item()
		if item and item.name == "plough":
			pass
	if Input.is_action_just_pressed("rightclick"):
		var item = get_selected_item()
		if item and item.item_type == "seed":
			seedsow()
func seedsow():
	var item = get_selected_item()
	inventory.use_Item_at_Index(inventory.selected_index)
	world.sow(item.crop_item)

func _physics_process(delta: float) -> void:
	if dying:
		return
	
	if using_tool:
		return
	if Input.is_action_pressed("hit"):
		var item = get_selected_item()
		if item and item.item_type == "axe":
			chop()
			return
	player_movement(delta)
	
	
	
func player_movement(delta):
	velocity = Vector2.ZERO
	var input_velocity = Vector2.ZERO
	if Input.is_action_pressed("right"):
		current_dir = "right"
		play_anim(1)
		input_velocity.x = speed
	elif Input.is_action_pressed("left"):
		current_dir = "left"
		play_anim(1)
		input_velocity.x = -speed
	elif Input.is_action_pressed("forward"):
		current_dir = "down"
		play_anim(1)
		input_velocity.y = speed
	elif Input.is_action_pressed("backward"):
		current_dir = "up"
		play_anim(1)
		input_velocity.y = -speed
	else:
		play_anim(0)
		input_velocity = Vector2.ZERO
		
	velocity = input_velocity + knockback
	knockback = knockback.move_toward(Vector2.ZERO, 500 * delta)
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
	await get_tree().create_timer(0.15).timeout
	if blob:
		var facing = Vector2.ZERO
		match current_dir:
			"right":
				facing = Vector2.RIGHT
			"left":
				facing = Vector2.LEFT
			"up":
				facing = Vector2.UP
			"down":
				facing = Vector2.DOWN
		for blob in get_tree().get_nodes_in_group("enemy"):
			var blob_hit = (blob.global_position - global_position).normalized()
			var hit = facing.dot(blob_hit) > 0.5
			if hit and global_position.distance_to(blob.global_position) < 25:
				blob.blob_healthdown(2, global_position)
		await  animated_sprite_2d.animation_finished
		using_tool = false
		
	await  animated_sprite_2d.animation_finished
	using_tool = false
func use_item(item: InventoryItem) -> void:
	item.use(self)
func get_selected_item() -> InventoryItem:
	return inventory.slots[inventory.selected_index].item
func increase_health(amount: int):
	ui.healthup(amount)
func decrease_health(amount: int):
	animated_sprite_2d.position.y -= 1.6
	modulate = Color.CRIMSON
	await get_tree().create_timer(0.2).timeout
	animated_sprite_2d.position.y += 1.6
	modulate = Color("ffffff")
	ui.healthdown(amount)
	if ui.health <= 0 and !dying:
		player_dying()
@onready var ui: ui = $"../CanvasLayer/ui"
@onready var marker_2d: Marker2D = $Marker2D
@onready var camera_2d: Camera2D = $Camera2D
@onready var invenrory: Control = $"../CanvasLayer/invenrory"
signal player_dead
@onready var dialouge: Control = $"../CanvasLayer/dialouge"
@onready var workshop: Control = $"../CanvasLayer/workshop"

func player_dying():
	var tween = create_tween()
	tween.set_parallel()
	dying = true
	ui.visible = false
	invenrory.visible = false
	dialouge.visible = false
	workshop.visible = false
	
	player_dead.emit()
	tween.tween_property(camera_2d,"zoom",Vector2(6.8, 6.8), 0.8)
	tween.tween_property(camera_2d,"rotation_degrees",40.0, 2)
	animated_sprite_2d.play("die")
	tween.tween_property(ui,"modulate",Color("0000"),0.3)
	tween.tween_property(invenrory,"modulate",Color("0000"),0.3)
	
	
	await tween.finished
	await animated_sprite_2d.animation_finished
	queue_free()
	
