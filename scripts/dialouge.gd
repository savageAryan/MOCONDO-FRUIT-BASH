extends Control
@onready var label: Label = $Label
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var dialougespriteframe: AnimatedSprite2D = $Control/Dialougespriteframe
var current_npc = null
signal talk_finished
@onready var label_2: Label = $Label2
var dialouge_animation:SpriteFrames 
var dialogue = []
var current = 0
func show_line():
	label.text = dialogue[current]
	animation_player.play("monkeyspeak")
	
func start_dialogue(lines:Array, character_name, frame:SpriteFrames,animation_name,npc):
	current_npc = npc
	dialogue = lines
	current = 0
	label_2.text = character_name
	dialougespriteframe.sprite_frames = frame
	dialougespriteframe.play(animation_name)
	visible = true
	show_line()
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_crossbutton_pressed() -> void:
	dialougespriteframe.play("talk")
	current += 1
	if current >= dialogue.size():
		animation_player.stop()
		
		visible = false
		if current_npc:
			current_npc.dialouge_finished()
			
			current_npc = null

	else:
		show_line()

@onready var crossbutton: TextureButton = $Crossbutton

func _on_crossbutton_mouse_entered() -> void:
	crossbutton.modulate = Color("f50004c1")


func _on_crossbutton_mouse_exited() -> void:
	crossbutton.modulate = Color("b497537f")
