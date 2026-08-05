extends CanvasModulate
@export var gradient:GradientTexture1D
@export var time_speed = 0.02
var time:float = PI
var past_minute:float = -1.0
const minutes_per_dat = 1440
const minutes_per_hour = 60
const ingame_to_real_minute_duration = (2 * PI) / minutes_per_dat
signal time_tick(day:int, hour:int, minutes:int)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
func _physics_process(delta: float) -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	var value = (sin(Timemanager.time - PI / 2)+1.0)/2.0
	self.color = gradient.gradient.sample(value)
	recalculate_time()
func recalculate_time() -> void:
	var total_minutes = int(Timemanager.time/ ingame_to_real_minute_duration)
	var day = int(total_minutes/ minutes_per_dat)
	var currentday_min = total_minutes % minutes_per_dat
	var hour = int(currentday_min/ minutes_per_hour)
	var minutes = int(currentday_min % minutes_per_hour)
	if past_minute != minutes:
		past_minute = minutes
		time_tick.emit(day,hour,minutes)
