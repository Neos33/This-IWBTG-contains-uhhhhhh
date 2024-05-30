extends Node2D

@export var trigger_id: int = 0
@export var camera_main_scene: Camera2D

@onready var animation_player = $AnimationPlayer
@onready var camera_trap = $Camera2D
@onready var entities_group = $TrapNode
@onready var timer = $Timer

@onready var ellipse = $TrapNode/Node2D/Ellipse
@onready var mouth_interval = $MouthInterval

const CAMERA_SPEED = 750

var triggered: bool = false
var move_camera: bool = false
var mouth_scale = Vector2(24, 24)
var persistent_mouth: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	camera_trap.enabled = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GLOBAL_GAME.triggered_events.has(trigger_id) and !triggered:
		position = Vector2.ZERO
		animation_player.play("Trap_Setup")
		#GLOBAL_SOUNDS.play_sound(GLOBAL_SOUNDS.sndBlockChange)
		triggered = true
		# Deactivate main scene camera
		var _camera_position = camera_main_scene.position
		print(_camera_position)
		camera_main_scene.target_node = null
		#camera_main_scene.enabled = false
		#emit_signal("change_camera", false)
		# Activate penalty trap camera
		#camera_trap.enabled = true
		#camera_trap.position = _camera_position # Position to where the main camera was
		#print(camera_trap.position)
		# move the every object at the bottom of the screen
		entities_group.position = Vector2(_camera_position.x-400, _camera_position.y+304)
		
		move_camera = true
		timer.start()
		mouth_interval.start()
		
	if move_camera:
		camera_main_scene.position.y += CAMERA_SPEED * delta
		
	ellipse.size = lerp(ellipse.size, mouth_scale, 0.2)


func _on_timer_timeout():
	move_camera = false
	# Stop player move
	stop_player()
	#emit_signal("change_camera", false)

func stop_player():
	var _player = GLOBAL_INSTANCES.objPlayerID
	_player.frozen = true
	_player.no_gravity = true
	_player.player_sprites.speed_scale = 0
	
func mouth_size():
	persistent_mouth = true
	mouth_scale = Vector2(randf_range(24, 44), randf_range(16, 30))
	
func close_mouth():
	persistent_mouth = false
	mouth_scale = Vector2(3, 3)


func _on_mouth_interval_timeout():
	if persistent_mouth:
		mouth_size()
	else:
		close_mouth()
