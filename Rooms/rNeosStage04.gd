extends Node2D

@onready var pivot = $Room_related/objPlayer/Pivot
@onready var line_2d = $Room_related/objPlayer/Pivot/Line2D
@onready var obj_player = $Room_related/objPlayer
@onready var obj_camera_dynamic = $Room_related/objCameraDynamic
@onready var player_offset = $Room_related/objPlayer/Pivot/PlayerOffset
@onready var obj_moving_block = $Room_related/objMovingBlock


var angle: float = 0
var distance: float = 10
var offset_position: float = 152
const oscillate: float = 50
var cam_off: Vector2 = Vector2(0, -60)
var amount1: float = 2
var amount2: float = 4


# Called when the node enters the scene tree for the first time.
func _ready():
	update_chopper_position()
	obj_moving_block.visible = false
	if GLOBAL_GAME.autosave_after_transition:
		GLOBAL_SAVELOAD.save_game(true)
		GLOBAL_GAME.autosave_after_transition = false
		print("Game saved!")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_instance_valid(GLOBAL_INSTANCES.objPlayerID):
		angle += oscillate * delta
		pivot.rotation_degrees = sin(deg_to_rad(angle)) * distance
		var _add = amount1
		if Input.is_action_pressed("button_jump"):
			_add = amount2
		if Input.is_action_pressed("button_up"):
			offset_position -= _add
		if Input.is_action_pressed("button_down"):
			offset_position += _add
			
		offset_position = clamp(offset_position, 64, 240)
		update_chopper_position()
	
func update_chopper_position():
		obj_camera_dynamic.offset.y = offset_position + cam_off.y
		line_2d.points[0].y = offset_position
		player_offset.position.y = offset_position


func _on_killer_detect_body_entered(body):
	GLOBAL_INSTANCES.objPlayerID.on_death()
