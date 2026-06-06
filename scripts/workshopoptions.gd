extends TextureRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var selected = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _physics_process(delta: float) -> void:
	pass


func _on_button_mouse_entered() -> void:
	animation_player.play("mousein")
	position.y -= 10
	position.x -= 5


func _on_button_mouse_exited() -> void:
	animation_player.play("mouseout")
	position.y += 10
	position.x += 5


func _on_button_pressed() -> void:
	pass
	


func _on_button_button_down() -> void:
	animation_player.play("mouseout")
	position.x += 2
	position.y += 3


func _on_button_button_up() -> void:
	animation_player.play("mousein")
	position.x -=2
	position.y -= 3
