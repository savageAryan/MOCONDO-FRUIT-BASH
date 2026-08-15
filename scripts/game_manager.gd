extends Node2D

var wheat = 0
var apple = 0
var banana = 0
var strawberry = 0
var mango = 0
var log = 0
var rootseed = 0
var gold = 100
var monkey_talked:bool = false
var chicken_talked:bool = false
var capybara_talked:bool = false
var blob_talked:bool = false
var carrot = 0
var tomato = 0
var carrot_seed = 0
var tomato_seed = 0
var monkey_workshop:bool = false
var talking:bool = false
var using_workshop:bool = false

var scene_path
var time_elapsed
var scene_loading:bool = false
signal scene_loaded
func load_scene(scene: String):
	get_tree().change_scene_to_file("res://scenes/loadingscreen.tscn")
	await get_tree().create_timer(5).timeout
	if scene:
		scene_path = scene
		time_elapsed = Time.get_ticks_msec()
		ResourceLoader.load_threaded_request(scene_path)
		scene_loading = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if scene_loading:
		var progress = []
		var status = ResourceLoader.load_threaded_get_status(scene_path,progress)
		if status == ResourceLoader.ThreadLoadStatus.THREAD_LOAD_IN_PROGRESS:
			print("loading")
		if status == ResourceLoader.ThreadLoadStatus.THREAD_LOAD_LOADED:
			print("loaded")
		time_elapsed = Time.get_ticks_msec() - time_elapsed
		print(time_elapsed)
		scene_loading = false
		scene_loaded.emit()
	
