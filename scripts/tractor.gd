extends CharacterBody2D
var current_dir = "none"

var speed = 200

@onready var wheatlandtile: TileMapLayer = $"../wheatlandtile"
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	player_movement(delta)
	cut_wheat()
	
func player_movement(delta):
	if Input.is_action_pressed("right"):
		current_dir = "right"
		
		
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("left"):
		current_dir = "left"
		
		
		velocity.x = -speed
		velocity.y =0
	elif Input.is_action_pressed("forward"):
		current_dir = "down"
		
		velocity.x = 0
		velocity.y = speed
	elif Input.is_action_pressed("backward"):
		current_dir = "up"
		
		velocity.x = 0
		velocity.y = -speed
	else:
		
		velocity.x = 0
		velocity.y = 0
		
	move_and_slide()
	
	if velocity.length()> 0:
		rotation = velocity.angle() + deg_to_rad(90)








func cut_wheat():
	var tilemap = get_tree().get_first_node_in_group("tilemap")
	
	if tilemap == null:
		return

		
	var local_pos = tilemap.to_local($wheatcutter.global_position)
	var cell = tilemap.local_to_map(local_pos)
	var atlas = tilemap.get_cell_atlas_coords(cell)
	
	
	if atlas == Vector2i(-1, -1):
		
		return
		
	if atlas == Vector2i(1, 0):
		tilemap.set_cell(cell,0,Vector2i(0,0))
		
		regrow(tilemap, cell)

	
func regrow(tilemap, cell):
	
	await get_tree().create_timer(15.0).timeout
	tilemap.set_cell(cell,0,Vector2i(1, 0))
		
