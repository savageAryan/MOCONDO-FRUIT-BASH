extends CharacterBody2D

@onready var workshopsprite: AnimatedSprite2D = $"../workshopbody/Workshopsprite"
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var dialouge: Control = $"../CanvasLayer/dialouge"
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var stage = 0

signal monkey
signal out

func _ready() -> void:
	if GameManager.monkey_workshop:
		global_position = workshopsprite.global_position
		collision_shape_2d.scale *= 2
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if GameManager.monkey_talked:
			return
		match stage:
			0:
				dialouge.start_dialogue([
		"HEYYY!!",
		"Wassup!, You'r new here?",
		"Don't Worry, I Will Help Yuhh",
		"This Is MOCONDO ISLAND
		Full of Fruits and Goodness",
		"But Turns dangerous,rabid sometimes
		mostly at night",
		"Don't worry You can Sleep in My Hut
		I Can Sleep in My WorkShop, So Its Fine",
		"You Should Go to BOGOTA, You will Find
		People of your kind there 'HUMANS' 
		TheY Are Organising a Ritual There",
		"They Call it HA.. Hackthunn",
		"BEST OF LUCK!.... BTW You Can Find me
		In MY Workshop,And BUY and SELL Stuff",
		"See YUUUHHH!"
	],"---THE MONKEY-KING",animated_sprite_2d.sprite_frames,"talk",self)
				monkey.emit()
			1:
				dialouge.start_dialogue(["Hey, Welcome,",
		"I New Yuhh Wood Come",
		"Yehh! This My Workshop!",
		"Let Meh No If Yuhh Need SomeTHing",
		"OKAYYY!?",
		"mm"],"---THE MONKEY-KING",workshopsprite.sprite_frames,"talk",self)
				monkey.emit()
		


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
			
			out.emit()


func dialouge_finished():
	out.emit()
	match stage:
		0:
			workshopsprite.play("monkey workshop")
			stage = 1
			animated_sprite_2d.visible = false
			global_position = workshopsprite.global_position
			collision_shape_2d.scale *= 2
		1:
			GameManager.monkey_workshop = true
			GameManager.monkey_talked = true
			stage = 2
			queue_free()
	
