extends Node2D
@onready var timer: Timer = $Timer
@onready var control: Control = $CanvasLayer/Control
@onready var house: AnimatedSprite2D = $StaticBody2D/house
@onready var button_2: Button = $Button2
@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var workshop: Control = $CanvasLayer/workshop
@onready var button: Button = $Button
@onready var canvas_modulate: CanvasModulate = $CanvasModulate
@onready var death_scene: Control = $"CanvasLayer/death scene"
@onready var chicken: CharacterBody2D = $chicken
@onready var dialouge: Control = $CanvasLayer/dialouge
@onready var monkey: CharacterBody2D = $monkey
@onready var player: Player = $"../player"
@onready var ui: Control = $CanvasLayer/ui
@onready var plantedlayer: TileMapLayer = $plantedlayer
@onready var carrot_crop: Area2D = $"carrot crop"
@onready var tomato_crop: Area2D = $"tomato crop"
@onready var workshopsprite: AnimatedSprite2D = $workshopbody/Workshopsprite
@onready var tile_map_layer: TileMapLayer = $TileMapLayer
var planted_cell = {}
signal tilled
const CARROT_CROP = preload("res://scenes/carrot_crop.tscn")
func _process(delta: float) -> void:
	pass
func ui_busy() -> bool:
	return(workshop.visible
	or death_scene.visible
	or dialouge.visible)
func land_tilled():
	var mouse_pos = get_global_mouse_position()
	var cell = tile_map_layer.local_to_map(mouse_pos)
	var cell_data = tile_map_layer.get_cell_tile_data(cell)
	if plantedlayer.get_cell_source_id(cell) != -1:
		return false
	if cell_data == null:
		return false
	if cell_data.get_custom_data("untilled"):
		tile_map_layer.set_cell(cell,3,Vector2i(0,0),1)
		tilled.emit()
		return true
func land_untilled(cell: Vector2i):
	var cell_data = tile_map_layer.get_cell_tile_data(cell)
	if cell_data == null:
		return false
	if cell_data.get_custom_data("farmable"):
		tile_map_layer.set_cell(cell,4,Vector2i(10,6))
func sow(CROP):
	var mouse_pos = get_global_mouse_position()
	var cell = tile_map_layer.local_to_map(mouse_pos)
	var cell_data = tile_map_layer.get_cell_tile_data(cell)
	if plantedlayer.get_cell_source_id(cell) != -1:
		return false
	if cell_data == null:
		return false
		
	if cell_data.get_custom_data("farmable"):
		var crop = CROP.instantiate()
		add_child(crop)
		crop.cell_pos = cell
		crop.harvested.connect(_on_crop_harvested)
		crop.global_position = tile_map_layer.to_global(tile_map_layer.map_to_local(cell))
		plantedlayer.set_cell(cell,0,Vector2i.ZERO)
		return true
func _on_carrot_crop_harvested(cell: Vector2i) -> void:
	var pos = tile_map_layer.local_to_map(carrot_crop.global_position)
	land_untilled(pos)
func _on_tomato_crop_harvested(cell: Vector2i) -> void:
	var pos = tile_map_layer.local_to_map(tomato_crop.global_position)
	land_untilled(pos)

func _on_crop_harvested(cell: Vector2i):
	plantedlayer.erase_cell(cell)
	land_untilled(cell)
func _ready() -> void:
	canvas_modulate.time_tick.connect(ui.set_daytime)
	blob_spawn()
	
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

func _on_workshop_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		button_3.visible = true
func _on_workshop_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		ui.visible = true
		button_3.visible = false
		workshop.visible = false
		ui.visible = true
		invenrory.visible = true
@onready var invenrory: Control = $CanvasLayer/invenrory
@onready var button_3: Button = $workshopbody/Button3


var workshop_opened = false

func _on_button_3_pressed() -> void:
	GameManager.using_workshop = true
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
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Inventory"):
		
		if invenrory.isopen:
			ui.inventory_close()
			invenrory.close()
			
		else:
			invenrory.open()
			ui.inventory_open()
			
@onready var texture_button = $invenrory/TextureButton
const BOLB = preload("res://scenes/bolb.tscn")
func blob_spawn():
	var point = points.pick_random()
	var blobenemy = BOLB.instantiate()
	blobenemy.global_position  = point.global_position
	add_child(blobenemy)
@onready var points = $points.get_children()


func _on_monkey_monkey() -> void:
	match monkey.stage:
		0:
			invenrory.visible = false
			ui.visible = false
		1:
			invenrory.visible = false
			ui.visible = false
		2:
			pass
func _on_monkey_out() -> void:
	dialouge.visible = false
	invenrory.visible = true
	ui.visible = true
func _on_dialouge_talk_finished() -> void:
	invenrory.visible = true
	ui.visible = true
	dialouge.visible = false
func _on_chicken_chicken_in() -> void:
	if chicken.moving:
		return
	invenrory.visible = false
	ui.visible = false
	match chicken.stage:
		0:
			pass
func _on_chicken_chicken_out() -> void:
	match chicken.stage:
		5:
			dialouge.visible = false
			invenrory.visible = true
			ui.visible = true
	if chicken.moving:
		return
	if chicken.talking:
		return
	dialouge.visible = false
	invenrory.visible = true
	ui.visible = true
func _on_capybara_capybara_in() -> void:
	invenrory.visible = false
	ui.visible = false
func _on_capybara_capybara_out() -> void:
	dialouge.visible = false
	invenrory.visible = true
	ui.visible = true
func _on_blob_blob_in() -> void:
	invenrory.visible = false
	ui.visible = false
func _on_blob_blob_out() -> void:
	dialouge.visible = false
	invenrory.visible = true
	ui.visible = true
