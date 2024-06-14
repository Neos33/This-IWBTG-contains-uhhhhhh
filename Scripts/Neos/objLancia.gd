extends CharacterBody2D


@export var speed = 200.0

var crashed : bool = false
var flag_crashed : bool = false
var start_moving: bool = false

@onready var block_detection = $BlockDetection/CollisionBlock
@onready var path_2d = $Path2D

@onready var path_follow_2d = $Path2D/PathFollow2D
@onready var car = $Path2D/PathFollow2D/Car
@onready var sprite_car = $SpriteCar
@onready var hitbox = $Hitbox
@onready var sfx_crash = $sfxCrash
@onready var race_status_text = $RaceStatusText
@onready var music_win = $MusicWin

func _ready():
	car.visible = false
	
	
func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if start_moving:
		velocity.x = speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	# Not able to move if we already crashed
	if not crashed:
		move_and_slide()
		
	#car.rotation = lerp(0, 180, path_follow_2d.progress_ratio)


func _on_block_detection_body_entered(body):
	if not crashed:
		#GLOBAL_SOUNDS.play_sound(GLOBAL_SOUNDS.sndBlockChange)
		sfx_crash.play()
		crashed = true
		var _tween = create_tween()
		_tween.tween_property(path_follow_2d, "progress_ratio", 1, 3.0)
		_tween.set_parallel().tween_property(car, "rotation", 4, 3.0)
		
		car.visible = true
		sprite_car.visible = false
		hitbox.disabled = true
		hitbox.position = Vector2(-2000, -2000)
		block_detection.disabled = true
		await(_tween.finished)
		update_text("You won")
		music_win.play()
		music_win.volume_db = linear_to_db(0.6)
		GLOBAL_MUSIC.stop_music()
		

func update_text(label, text_position = Vector2(0, 0)):
	race_status_text.text = label
	race_status_text.position += text_position
