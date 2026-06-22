extends Sprite2D
var speed = 2
var follow_distance = 20
func _process(delta: float) -> void:
	
	var mouse_position = get_global_mouse_position()
	
	var direction = (mouse_position - global_position).normalized()
	var target_pos = mouse_position -  direction * follow_distance
	global_position = global_position.lerp(target_pos,speed * delta)
	if direction.length() > 0:
		rotation = direction.angle() + deg_to_rad(90)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
