extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.scene_loaded.connect(_on_screen_loaded)

func _on_screen_loaded():
	var packed_scene = ResourceLoader.load_threaded_get(GameManager.scene_path)
	get_tree().change_scene_to_packed(packed_scene)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
