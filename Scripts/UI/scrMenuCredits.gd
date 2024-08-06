extends Control

@export_file("*.tscn") var main_menu: String
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_select"):
		get_tree().change_scene_to_file(main_menu)
		GLOBAL_SOUNDS.play_sound(GLOBAL_SOUNDS.sndPause)

