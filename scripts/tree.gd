extends StaticBody2D
const fruits = [preload("res://scenes/apple.tscn"),
preload("res://scenes/banana.tscn"),
preload("res://scenes/strawberry.tscn"),
preload("res://scenes/mango.tscn"),
preload("res://scenes/apple.tscn"),
preload("res://scenes/apple.tscn"),
preload("res://scenes/apple.tscn"),
preload("res://scenes/apple.tscn"),
preload("res://scenes/banana.tscn"),
preload("res://scenes/banana.tscn"),
preload("res://scenes/banana.tscn"),
preload("res://scenes/banana.tscn"),
preload("res://scenes/banana.tscn"),
preload("res://scenes/strawberry.tscn"),
preload("res://scenes/banana.tscn"),
preload("res://scenes/strawberry.tscn"),
preload("res://scenes/strawberry.tscn"),
preload("res://scenes/banana.tscn"),
preload("res://scenes/apple.tscn"),
preload("res://scenes/apple.tscn"),]









# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	var randomm_fruit = fruits.pick_random()
	
	
	var fruit = randomm_fruit.instantiate()
	fruit.global_position = global_position + Vector2(randi_range(-30,50),54)

	get_tree().current_scene.call_deferred("add_child", fruit)
	print ("fruit spawned")
	
	
