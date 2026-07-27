extends CharacterBody2D
@onready var dialouge: Control = $"../CanvasLayer/dialouge"
@onready var control: Control = $CanvasLayer/Control
@onready var invenrory: Control = $"../CanvasLayer/invenrory"
@onready var ui: ui = $"../CanvasLayer/ui"
@onready var talkbuttonsprite: AnimatedSprite2D = $talkbuttonsprite
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var facing = "null"
signal chicken_in
signal chicken_out
var moving:bool = false
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		chicken_in.emit()
		if GameManager.chicken_talked:
			ui.visible = false
			invenrory.visible = false
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
	control.pop_in()
	control.visible = true
	talkbuttonsprite.visible = true
	
func move_farm():
	var direction = (Vector2(-11,135) - global_position).normalized()
	control.visible = false
	velocity = velocity.move_toward(direction * 20,120)
	move_and_slide()
	
	if abs(direction.x) > abs(direction.y) and velocity != Vector2.ZERO:
		facing = "side"
		if direction.x > 0:
			animated_sprite_2d.play("side walk")
			animated_sprite_2d.flip_h = true
		else:
			animated_sprite_2d.play("side walk")
			animated_sprite_2d.flip_h = false
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
	moving = true
func _physics_process(delta: float) -> void:
	if moving:
		move_farm()


func _on_talk_button_pressed() -> void:
	pass
