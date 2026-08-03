class_name ui extends Control
@onready var ampmlabel: Label = $TimeUiDisplay/ampmlabel
@onready var hotbar: Sprite2D = $hotbar


var health = 8
var max_health = 10
@onready var daylabel: Label = $TimeUiDisplay/daylabel
@onready var timelabel: Label = $TimeUiDisplay/timelabel
@onready var weekdaylabel_2: Label = $TimeUiDisplay/weekdaylabel2


var Inventory = "closed"

var suffix = "none"
const days = ["MONDAY",
"TUESDAY",
"WEDNSDAY",
"THURSDAY",
"FRIDAY",
"SATURDAY",
"SUNDAY"]
@onready var hearts = $hearts.get_children()
func _ready() -> void:
	heart_anim()

func heart_anim():
	var hp = health
	for heart in hearts:
		if hp >= 2:
			heart.play("full")
			hp -= 2
		elif hp == 1:
			heart.play("half")
		else: heart.play("empty")
func healthdown(amount):
	health = max(0 ,health - amount)
	heart_anim()
	animation_player_2.play("hearts animation")
func healthup(amount):
	health = min(max_health, health + amount)
	heart_anim()
	animation_player_2.play("hearts animation")
@onready var animation_player_2: AnimationPlayer = $AnimationPlayer2

# Called when the node enters the scene tree for the first time.

	
@onready var arrow: AnimatedSprite2D = $TimeUiDisplay/arrow
@onready var pausebutton: TextureButton = $pausebutton
@onready var workshop: Control = $"../workshop"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	goldcount()
	ampmlabel.text = suffix
	if Input.is_action_just_pressed("pause") :
		paused = not paused
		
		pausemenu.pausemenu_show()
		pausebutton.button_pressed = paused
		pausemenu.visible = paused
		time_ui_display.visible = not paused
		invenrory.visible = not paused
		heart.visible = !paused
		get_tree().paused = paused
	
	
		
		
	
	
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
	invenrory.visible = not paused
	get_tree().paused = paused
	heart.visible = not paused
@onready var invenrory: Control = $"../invenrory"
@onready var heart: Control = $hearts


func workshop_close():
	time_ui_display.visible = true
	pausebutton.visible = true
	

		
@onready var panel_2: TextureRect = $Panel2

@onready var label: Label = $Panel2/Label
func goldcount():
	label.text = str(GameManager.gold)
func inventory_open():
	var gold_tween = create_tween()
	


	gold_tween.tween_property(panel_2,"modulate",Color("0000"),0.1)

	gold_tween.tween_callback(func():panel_2.position = Vector2(257, 53))
	gold_tween.tween_property(panel_2,"modulate",Color("ffffff"),0.2)
	panel_2.scale = Vector2(0.65,0.65)
	time_ui_display.visible = false
	pausebutton.visible = false
func inventory_close():
	var gold_tween = create_tween()
	gold_tween.set_parallel()
	gold_tween.tween_property(panel_2,"position",Vector2(208,-6.2),0.1)
	panel_2.scale = Vector2(0.885,0.885)
	time_ui_display.visible = true
	pausebutton.visible = true
