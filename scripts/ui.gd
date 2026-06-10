extends Control
@onready var ampmlabel: Label = $TimeUiDisplay/ampmlabel
@onready var mangolabel: Label = $inventory/AnimatedSprite2D/mangolabel
@onready var applelabel: Label = $inventory/AnimatedSprite2D2/applelabel
@onready var strawberrylabel: Label = $inventory/AnimatedSprite2D3/strawberrylabel
@onready var bananalabel: Label = $inventory/AnimatedSprite2D4/bananalabel



@onready var daylabel: Label = $TimeUiDisplay/daylabel
@onready var timelabel: Label = $TimeUiDisplay/timelabel
@onready var weekdaylabel_2: Label = $TimeUiDisplay/weekdaylabel2
@onready var inventory: Sprite2D = $inventory
var Inventory = "closed"

var suffix = "none"
const days = ["MONDAY",
"TUESDAY",
"WEDNSDAY",
"THURSDAY",
"FRIDAY",
"SATURDAY",
"SUNDAY"]



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	inventory.visible = false
	
@onready var arrow: AnimatedSprite2D = $TimeUiDisplay/arrow
@onready var pausebutton: TextureButton = $pausebutton


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	ampmlabel.text = suffix
	if Input.is_action_just_pressed("pause"):
		paused = not paused
		
		pausemenu.pausemenu_show()
		pausebutton.button_pressed = paused
		pausemenu.visible = paused
		time_ui_display.visible = not paused

		get_tree().paused = paused
	mangolabel.text = str(GameManager.mango)
	applelabel.text = str(GameManager.apple)
	strawberrylabel.text = str(GameManager.strawberry)
	bananalabel.text = str(GameManager.banana)
	if Input.is_action_just_pressed("Inventory") and Inventory == "closed":
		inventory.visible = true
		Inventory = "open"
	else:
		if Input.is_action_just_pressed("Inventory") and Inventory == "open":
			inventory.visible = false
			Inventory = "closed"
	
		
		
	
	
func set_daytime(day:int, hour:int,minute:int):
	daylabel.text = "DAY " + str(day + 1)
	weekdaylabel_2.text =  days[day % 7]
	timelabel.text = "%02d:%02d" % [hour,minute]
	if hour >= 5 and hour <= 7:
		arrow.frame = 0
	elif hour >= 8 and hour <= 10:
		arrow.frame = 1
	elif hour >= 10 and hour <= 11:
		arrow.frame = 2
	elif hour >= 12 and hour <= 16:
		arrow.frame = 2
	elif hour == 17:
		arrow.frame = 3
	elif hour == 18:
		arrow.frame = 4
	elif hour == 19:
		arrow.frame = 5
	elif hour == 20 and hour <= 22:
		arrow.frame = 6
	elif hour == 23 and hour >= 2:
		arrow.frame = 7
	elif hour == 3 and hour <= 4:
		arrow.frame = 8
		
	if hour >= 12:
		suffix = "PM"
	else: suffix = "AM"


@onready var pausemenu: Control = $pausemenu
@onready var time_ui_display: Sprite2D = $TimeUiDisplay

var paused = false


	


func _on_pausebutton_pressed() -> void:
	paused = not paused
	pausemenu.visible = paused
	pausemenu.pausemenu_show()
	time_ui_display.visible = not paused
	get_tree().paused = paused
	
	

	
