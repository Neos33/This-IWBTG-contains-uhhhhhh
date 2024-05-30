extends Node2D

@onready var obj_camera_fixed = $Room_related/objCameraFixed


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_race_countdown_change_camera_focus():
	obj_camera_fixed.enabled = false


func _on_race_countdown_counter_finished():
	obj_camera_fixed.enabled = true


