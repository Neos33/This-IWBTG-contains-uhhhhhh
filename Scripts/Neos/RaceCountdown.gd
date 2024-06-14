extends Control

@export var target_instance_zoom: Node2D
@export var trigger_id: int = 0
@onready var camera_meme = $CameraMeme
@onready var animation_player = $CanvasLayer/AnimationPlayer

var triggered: bool = false
var music_muted: bool = false

signal change_camera_focus
signal counter_finished
signal race_started

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GLOBAL_GAME.triggered_events.has(trigger_id) and !triggered:
		animation_player.play("counter")
		GLOBAL_SOUNDS.play_sound(GLOBAL_SOUNDS.sndBlockChange)
		triggered = true
		
		# Make player stop
		GLOBAL_INSTANCES.objPlayerID.frozen = true
		GLOBAL_INSTANCES.objPlayerID.velocity.x = 0
	

func resize_camera():
	var _save_camera_pos = camera_meme.position
	var _target_pos = target_instance_zoom.position
	emit_signal("change_camera_focus")
	
	# Switch cameras
	camera_meme.enabled = true
	# Sets pause mode to not affect this world script
	process_mode = PROCESS_MODE_ALWAYS
	# Pauses the game
	set_pause_mode(true)
	
	# Pause the song 
	if GLOBAL_GAME.music_is_playing == true:
		GLOBAL_GAME.music_is_playing = false;
		music_muted = true
	
	var _tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	_tween.tween_property(camera_meme, "position", _target_pos, 1.0)
	_tween.set_parallel().tween_property(camera_meme, "zoom", Vector2(3, 3), 1.0)
	#_tween.set_parallel().tween_property($ColorRect, "color", Color.BLACK, 1.0)
	
	
	await(_tween.finished)
	var cooldown = get_tree().create_timer(1.0)
	await(cooldown.timeout)
	
	#Reset values after the tween is done
	camera_meme.position = _save_camera_pos
	camera_meme.zoom = Vector2(1, 1)
	camera_meme.enabled = false
	print("Done")
	
	


func _on_animation_player_animation_finished(anim_name):
	print("Animation finished")
	emit_signal("counter_finished")

	process_mode = Node.PROCESS_MODE_INHERIT
	# Unpauses the game
	set_pause_mode(false)
	# Unpauses the song 
	if music_muted:
		GLOBAL_GAME.music_is_playing = true;
	# Delete scene
	queue_free()

func set_pause_mode(mode: bool):
	GLOBAL_GAME.game_paused = mode
	get_tree().set_pause(mode)
	GLOBAL_GAME.can_pause = !mode
	
func lights_out_and_away_we_go():
	emit_signal("race_started")
	
