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


func _physics_process(delta: float) -> void:
	treecut(delta)


const LOG = preload("uid://m4h7dpmsqlhv")





# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	treecut(delta)


func _on_timer_timeout() -> void:
	var randomm_fruit = fruits.pick_random()
	
	
	var fruit = randomm_fruit.instantiate()
	fruit.global_position = global_position + Vector2(randi_range(-30,50),54)

	get_tree().current_scene.call_deferred("add_child", fruit)
	print ("fruit spawned")

var player_neartree = false
var break_time = 0.0
var chopped = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_neartree = true
		

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_neartree = false
		
func treecut(delta):
	if Input.is_action_pressed("BREAK") and  player_neartree:
		if not chopped:
			break_time += delta
			if break_time >= 3.0:
				
	
				var log = LOG.instantiate()
				log.global_position = global_position + Vector2(randi_range(-10,30),randi_range(30,10))
				
				get_tree().current_scene.call_deferred("add_child", log)
				
				chopped = true
		else:
			break_time = 0.0
			chopped = false
