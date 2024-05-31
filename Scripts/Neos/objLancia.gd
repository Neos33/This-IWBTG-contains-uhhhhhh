extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var crashed : bool = false
var flag_crashed : bool = false

@onready var block_detection = $BlockDetection/CollisionBlock
@onready var path_2d = $Path2D

@onready var path_follow_2d = $Path2D/PathFollow2D
@onready var car = $Path2D/PathFollow2D/Car
@onready var sprite_car = $SpriteCar

func _ready():
	car.visible = false
	
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor() and crashed and not flag_crashed:
		flag_crashed = true
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if not crashed:
		move_and_slide()


func _on_block_detection_body_entered(body):
	if not crashed:
		GLOBAL_SOUNDS.play_sound(GLOBAL_SOUNDS.sndBlockChange)
		crashed = true
		var _tween = create_tween()
		_tween.tween_property(path_follow_2d, "progress_ratio", 1, 3.0)
		_tween.set_parallel().tween_property(car, "rotation", 4, 3.0)
		car.visible = true
		sprite_car.visible = false
		
	block_detection.disabled = true
