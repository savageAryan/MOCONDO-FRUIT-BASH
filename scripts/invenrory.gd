extends Control
var isopen: bool = false
signal opened
signal closed
@onready var texture_rect: TextureRect = $TextureRect
@onready var hotbar: TextureRect = $hotbar
@onready var inventory: Inventory = preload("res://inventory/player_inventory.tres")
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var slots: Array = $TextureRect/GridContainer.get_children()

func update():
	for i in range(min(inventory.items.size(), slots.size())):
		slots[i].update(inventory.items[i])
		print("invo updated")
func open():
	texture_rect.visible = true
	opened.emit()
	isopen = true
	
func close():
	texture_rect.visible = false
	closed.emit()
	
	
	
	isopen = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture_rect.visible = false
	update()
	inventory.updated.connect(update)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
