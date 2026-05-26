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

var suffix = "AM"
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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
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
	arrow.frame = int(remap(hour,0,23,0,8))
	if hour >= 12:
		suffix = "PM"
	ampmlabel.text = suffix
