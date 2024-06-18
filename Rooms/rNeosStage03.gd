extends Node2D

@onready var animation_player = $Gimmicks/AnimationPlayer
@onready var mario_animation = $Gimmicks/MarioGroup/MarioAnimation

@onready var pipe_sfx = $Gimmicks/MarioGroup/PipeSFX

var sound_area_enabled: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.play("up_down", -1, 2.0)
	mario_animation.play("MarioGoing", -1, 2.0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func mario_pipe_sound():
	if sound_area_enabled:
		pipe_sfx.play()
		pipe_sfx.volume_db = linear_to_db(0.8)

func _on_area_2d_body_entered(body):
	sound_area_enabled = true


func _on_area_2d_body_exited(body):
	sound_area_enabled = false
	pipe_sfx.stop()


func _on_bullet_detector_body_entered(body):
	mario_animation.stop()
	$Gimmicks/MarioGroup/Mario.visible = false
	var killer_col = $Gimmicks/MarioGroup/Hitbox
	killer_col.disabled = true
	killer_col.position = Vector2(-1000, -1000)

