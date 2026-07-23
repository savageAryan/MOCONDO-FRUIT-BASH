extends CharacterBody2D
@onready var dialouge: Control = $"../CanvasLayer/dialouge"
@onready var control: Control = $CanvasLayer/Control
@onready var invenrory: Control = $"../CanvasLayer/invenrory"
@onready var ui: ui = $"../CanvasLayer/ui"
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var talked = false
signal chicken_in
signal chicken_out
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		chicken_in.emit()
		if talked:
			ui.visible = false
			invenrory.visible = false
			control.visible = true
			control.pop_in()
			return
		if talked == false:
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
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		control.visible = false
		ui.visible = false
		invenrory.visible = false
		chicken_out.emit()
		control.visible = false
		control.pop_out()
func dialouge_finished():
	talked = true
	control.pop_in()
	control.visible = true
