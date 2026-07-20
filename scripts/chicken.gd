extends CharacterBody2D
@onready var dialouge: Control = $"../CanvasLayer/dialouge"
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

signal chicken_in
signal chicken_out
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
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
		],"---FARMING CHICKEN",animated_sprite_2d.sprite_frames,"talk")
		chicken_in.emit()

func _on_area_2d_body_exited(body: Node2D) -> void:
	chicken_out.emit()
