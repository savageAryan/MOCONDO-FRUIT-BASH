extends CharacterBody2D

@onready var workshopsprite: AnimatedSprite2D = $"../workshopbody/Workshopsprite"

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var dialouge: Control = $"../CanvasLayer/dialouge"
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


signal monkey
signal out
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and !GameManager.monkey_talked:
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


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
			
			out.emit()


func dialouge_finished():
	GameManager.monkey_talked = true
	workshopsprite.play("monkey workshop")
	out.emit()
	await get_tree().create_timer(0.5).timeout
	queue_free()
