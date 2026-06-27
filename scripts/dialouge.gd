extends Control
@onready var label: Label = $Label
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var dialogue = []
var current = 0
func show_line():
	label.text = dialogue[current]
	animation_player.play("monkeyspeak")
func start_dialogue(lines:Array):
	dialogue = lines
	current = 0
	visible = true
	show_line()
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_crossbutton_pressed() -> void:
	current += 1
	if current >= dialogue.size():
		animation_player.stop()
		visible = false
	else:
		show_line()
