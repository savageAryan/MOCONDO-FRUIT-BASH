extends TextureRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@export var item: SpriteFrames
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var texture_scale  = scale
@export var for_sell: bool = false
var selected = false
signal optionbutton
#@export var item_to_buy: InventoryItem
#@export var inventory: Inventory



# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	animated_sprite_2d.sprite_frames = item
	animated_sprite_2d.play("default")
@onready var color_rect: ColorRect = $ColorRect

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _physics_process(delta: float) -> void:
	
	if selected == true:
		color_rect.visible = true
		animation_player.play("selected")
	else:
		color_rect.visible = false
		


func _on_button_mouse_entered() -> void:
	animation_player.play("mousein")
	position.y -= 10
	position.x -= 5
	selected = true


func _on_button_mouse_exited() -> void:
	animation_player.play("mouseout")
	position.y += 10
	position.x += 5
	selected = false


#func _on_button_pressed() -> void:
	#if for_sell == true:
		#if inventory.remove_item(item_to_buy, 1):
			#GameManager.gold += item_to_buy.sell_price
	#else:
		#if GameManager.gold >= item_to_buy.buy_price:
		#	GameManager.gold -= item_to_buy.buy_price
		#	inventory.insert(item_to_buy)
	

func _on_button_button_down() -> void:
	animation_player.play("mouseout")
	position.x += 2
	position.y += 3


func _on_button_button_up() -> void:
	animation_player.play("mousein")
	position.x -=2
	position.y -= 3
