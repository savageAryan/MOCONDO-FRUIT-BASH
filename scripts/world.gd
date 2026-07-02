extends Node2D
@onready var timer: Timer = $Timer
@onready var control: Control = $CanvasLayer/Control




@onready var house: AnimatedSprite2D = $StaticBody2D/house
@onready var button_2: Button = $Button2

@onready var button: Button = $Button
@onready var canvas_modulate: CanvasModulate = $CanvasModulate


@onready var ui: Control = $CanvasLayer/ui



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	canvas_modulate.time_tick.connect(ui.set_daytime)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		house.play("gateopen")
		button.visible = true



func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		house.play("gateclosed")
		button.visible = false


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/home.tscn")


func _on_boatrest_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		button_2.visible = true


func _on_boatrest_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		button_2.visible = false


func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/boat.tscn")





@onready var canvas_layer: CanvasLayer = $CanvasLayer

@onready var workshop: Control = $CanvasLayer/workshop


func _on_workshop_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		
		button_3.visible = true
	
func _on_workshop_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		ui.visible = true
		button_3.visible = false
		workshop.visible = false
@onready var invenrory: Control = $CanvasLayer/invenrory

@onready var button_3: Button = $StaticBody2D3/Button3
var workshop_opened = false

func _on_button_3_pressed() -> void:
	workshop_opened = true
	workshop.visible = true
	ui.visible = false
	button_3.visible = false
	invenrory.visible = false
func _physics_process(delta: float) -> void:
	if workshop_opened == true:
		if Input.is_action_just_pressed("pause"):
			workshop_opened = false
			workshop.visible = false
			ui.visible = true
			button_3.visible = true
			invenrory.visible = true


@onready var dialouge: Control = $CanvasLayer/dialouge



func _on_monkey_monkey() -> void:
	dialouge.visible = true
	dialouge.start_dialogue([
		"HEYYY!!",
		"Wassup!, You'r new here?",
		"Don't Worry, I Will Help Yuhh",
		"This Is MOCONDO ISLAND
		Full of Fruits and Goodness",
		"But Turns dangerous,rabid sometimes
		mostly at night",
		"Don't worry You can Sleep in My Hut
		I Can Sleep in My WorkShop, So Its Fine",
		"You Should Go to BOGOTA, You will Find
		People of your kind there 'HUMANS' 
		TheY Are Organising a Ritual There",
		"They Call it HA.. Hackthunn",
		"BEST OF LUCK!.... BTW You Can Find me
		In MY Workshop,And BUY and SELL Stuff",
		"See YUUUHHH!"
		])
		

@onready var monkey: CharacterBody2D = $monkey

func _on_monkey_out() -> void:
	dialouge.visible = false





func _on_dialouge_talk_finished() -> void:
	monkey.queue_free()


func _on_damage_body_entered(body: Node2D) -> void:
	ui.healthdown(3)

@onready var player: Player = $"../player"


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Inventory"):
		
		if invenrory.isopen:
			ui.inventory_close()
			invenrory.close()
			
		else:
			invenrory.open()
			ui.inventory_open()
			
@onready var texture_button = $invenrory/TextureButton
