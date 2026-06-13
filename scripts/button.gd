extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_down() -> void:
	size.y += 13
	size.x += 13
	position.x -= 6
	


func _on_button_up() -> void:
	size.y -= 13
	size.x -= 13
	position.x += 6


@onready var animation_player: AnimationPlayer = $"../../../../AnimationPlayer"


func _on_mouse_entered() -> void:
	size.y += 15


func _on_mouse_exited() -> void:
	size.y -= 15


func _on_pressed() -> void:
	pass
	
