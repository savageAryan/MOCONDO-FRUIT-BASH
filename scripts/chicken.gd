extends CharacterBody2D
@onready var dialouge: Control = $"../CanvasLayer/dialouge"
@onready var control: Control = $CanvasLayer/Control
@onready var invenrory: Control = $"../CanvasLayer/invenrory"
@onready var ui: ui = $"../CanvasLayer/ui"
@onready var talkbuttonsprite: AnimatedSprite2D = $talkbuttonsprite
@onready var marker_2d: Marker2D = $"../Marker2D"
@onready var tomato_crop: Area2D = $"../tomato crop"
@onready var carrot_crop: Area2D = $"../carrot crop"
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var facing = "null"
signal chicken_in
signal chicken_out
var moving:bool = false
var stage := 0
var harvested:bool = false
var sleeping = false
var talking:bool = false
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if !GameManager.chicken_talked:
			talking = true
		chicken_in.emit()
		if GameManager.chicken_talked:
			ui.visible = false
			invenrory.visible = false
			if talking:
				control.visible = true
				control.pop_in()
			return
		if GameManager.chicken_talked == false:
			dialouge.start_dialogue([
				"WOHH! A Human!!?",
				"I Am Seeing One, After Ages",
				"Big Fan Sir!!",
				"Me!? I am Just A Simple
				 Farmer Of Mocondo Island",
				"BTWAYYY!, You Can Come 
				Here If You Want To Learn
				 Farming",
				"It Won't Be Free Though!
				 Just Sayinn."
				],"---FARMING CHICKEN",animated_sprite_2d.sprite_frames,"talk",self)
			talkbuttonsprite.visible = false
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		control.visible = false
		ui.visible = false
		invenrory.visible = false
		chicken_out.emit()
		control.visible = false
		control.pop_out()
		talkbuttonsprite.visible = true
func dialouge_finished():
	GameManager.chicken_talked = true
	talkbuttonsprite.visible = true
	talking = false
	match stage:
		0:
			GameManager.chicken_talked = true
			control.pop_in()
			talkbuttonsprite.visible = true
		1:
			moving = true
func move_chicken():
	var target_pos = marker_2d.global_position
	var distance = global_position.distance_to(target_pos)
	if distance < 2:
		global_position = target_pos
		velocity = Vector2.ZERO
		animated_sprite_2d.play("side idel")
		animated_sprite_2d.flip_h = true
		
		return
	var direction = (target_pos - global_position).normalized()
	control.visible = false
	velocity = direction * 20
	dialouge.visible = true
	move_and_slide()
	
	if abs(direction.x) > abs(direction.y) and velocity != Vector2.ZERO:
		facing = "side"
		if direction.x > 0:
			animated_sprite_2d.play("side walk")
			animated_sprite_2d.flip_h = false
		else:
			animated_sprite_2d.play("side walk")
			animated_sprite_2d.flip_h = true
	else:
		if direction.y > 0:
			facing = "front"
			animated_sprite_2d.play("front walk")
		else:
			facing = "back"
			animated_sprite_2d.play("side walk")

func _on_button_pressed() -> void:
	dialouge.start_dialogue(["HEY Human!",
	"How Are YOU.",
	"Lets Farm Soon, Yehh?.."],"---FARMING CHICKEN",animated_sprite_2d.sprite_frames,"talk",self)
	control.pop_out()
	talkbuttonsprite.visible = false
func _on_button_2_pressed() -> void:
	talkbuttonsprite.visible = false
	control.visible = false
	match stage:
		0:
			talking = true
			moving = true
			dialouge.start_dialogue(["Follow me!",
			"Farming Requires A Lot Of Patience 
			And Love",
			"If You Think You Have Those 
			I Am Willing To Teach You"],"---FARMING CHICKEN",animated_sprite_2d.sprite_frames,"talk",self)
			stage = 1
			
		1:
			talking = true
			dialouge.start_dialogue(["Okay So,",
			"You Can See Two Crops Grown
			here",
			"Left Click on Them TO Harvest",
			".."],"---FARMING CHICKEN",animated_sprite_2d.sprite_frames,"talk",self)
			stage = 2
			await harvested == true
			dialouge.start_dialogue(["WELLDONE!",
			"Now,Yoh Have Your Harvest",
			"Sell It..,Eat It.. Your Call",
			"But See The Ground Beneath",
			"Back to Being Untilled",
			"YOU Would Need A Plough!",
			"Till The "],"---FARMING CHICKEN",animated_sprite_2d.sprite_frames,"talk",self)
			
	
	var distance = global_position.distance_to(marker_2d.global_position)
	if distance < 2:
		moving = true
		marker_2d.global_position = Vector2(-109, 160)
	
func _physics_process(delta: float) -> void:
	if moving:
		move_chicken()

func _on_talk_button_pressed() -> void:
	pass
func _on_carrot_crop_harvested(cell: Vector2i) -> void:
	harvested = true
	if harvested:
		return
	harvested = true
	dialouge.start_dialogue(["WELLDONE!",
	"Now,Yoh Have Your Harvest",
	"Sell It..,Eat It.. Your Call",
	"But See The Ground Beneath",
	"Back to Being Untilled",
	"YOU Would Need A Plough!",
	"Till The "],"---FARMING CHICKEN",animated_sprite_2d.sprite_frames,"talk",self)
	stage = 3

func _on_tomato_crop_harvested(cell: Vector2i) -> void:
	harvested = true
	if harvested:
		return
	harvested = true
	dialouge.start_dialogue(["WELLDONE!",
	"Now,Yoh Have Your Harvest",
	"Sell It..,Eat It.. Your Call",
	"But See The Ground Beneath",
	"Back to Being Untilled",
	"YOU Would Need A Plough!",
	"Till The "],"---FARMING CHICKEN",animated_sprite_2d.sprite_frames,"talk",self)
	stage = 3
func sleep():
	await get_tree().create_timer(40).timeout
	marker_2d.global_position = Vector2(-14,161)
	await move_chicken()
	if moving == false:
		sleeping = true
		animated_sprite_2d.play("sleep")
		await get_tree().create_timer(10).timeout
		sleeping = false
		marker_2d.global_position = Vector2(-14,142)
		move_chicken()
		
