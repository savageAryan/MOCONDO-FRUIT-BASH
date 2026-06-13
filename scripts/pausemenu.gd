extends Control
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var texture_rect: TextureRect = $TextureRect
@onready var ui: Control = $".."
@onready var button: Button = $Panel/ScrollContainer/HBoxContainer/Button

func pausemenu_show():
	animation_player.play("pausemenuappear")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
