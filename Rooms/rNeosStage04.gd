extends Node2D

@onready var pivot = $Room_related/objPlayer/Pivot
@onready var line_2d = $Room_related/objPlayer/Pivot/Line2D
@onready var obj_player = $Room_related/objPlayer
@onready var obj_camera_dynamic = $Room_related/objCameraDynamic
@onready var player_offset = $Room_related/objPlayer/Pivot/PlayerOffset


var angle: float = 0
var distance: float = 10
var offset_position: float = 152


# Called when the node enters the scene tree for the first time.
func _ready():
	update_chopper_position()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	angle += 200 * delta
	pivot.rotation_degrees = sin(deg_to_rad(angle)) * distance
	if Input.is_action_pressed("button_up"):
		offset_position -= 2
	if Input.is_action_pressed("button_down"):
		offset_position += 2
		
	offset_position = clamp(offset_position, 64, 304)
	update_chopper_position()
	
func update_chopper_position():
		obj_camera_dynamic.offset.y = offset_position
		line_2d.points[0].y = offset_position
		player_offset.position.y = offset_position
