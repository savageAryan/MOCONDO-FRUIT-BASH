extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var camera_2d: Camera2D = $Camera2D


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("left"):
		rotation = 0.08
	else:
		rotation = 0
	if Input.is_action_pressed("right"):
		rotation = 0.08
		camera_2d.rotation = -0.08
	else:
		rotation = 0
	
	move_and_slide()
