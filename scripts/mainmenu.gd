extends Control
@onready var animation_player: AnimationPlayer = $AnimationPlayer



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_mocondorect_mouse_entered() -> void:
	animation_player.play("moconcorectpressed")


func _on_mocondorect_pressed() -> void:
	animation_player.play("moconcorectpressed")
