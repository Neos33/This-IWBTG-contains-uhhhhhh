extends Node2D

@onready var animation_player = $Gimmicks/AnimationPlayer
@onready var mario_animation = $Gimmicks/MarioGroup/MarioAnimation

@onready var pipe_sfx = $Gimmicks/MarioGroup/PipeSFX
@onready var mario_disappear = $Gimmicks/MarioGroup/MarioDisappear
@onready var mario_itself = $Gimmicks/MarioGroup/Mario

@onready var warp_troll_text = $Environment/WarpTrollText

var sound_area_enabled: bool = false
var mario_got_hit: bool = false

var triggered: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.play("up_down", -1, 2.0)
	mario_animation.play("MarioGoing", -1, 2.0)
	
	warp_troll_text.visible = GLOBAL_GAME.S3_text_twice_if_we_skip


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GLOBAL_GAME.triggered_events.has(1) and !triggered:
		triggered = true
		GLOBAL_GAME.S3_text_twice_if_we_skip = true
		
	if GLOBAL_GAME.autosave_after_transition:
		GLOBAL_SAVELOAD.save_game(true)
		GLOBAL_GAME.autosave_after_transition = false
		print("Game saved!")


func mario_pipe_sound():
	if sound_area_enabled:
		pipe_sfx.play()
		pipe_sfx.volume_db = linear_to_db(0.75)

func _on_area_2d_body_entered(body):
	sound_area_enabled = true


func _on_area_2d_body_exited(body):
	sound_area_enabled = false
	pipe_sfx.stop()


func _on_bullet_detector_body_entered(body):
	if !mario_got_hit:
		mario_animation.pause()
		# Audio
		pipe_sfx.stop()
		mario_disappear.play()
		mario_disappear.volume_db = linear_to_db(1.5)
		
		#$Gimmicks/MarioGroup/Mario.visible = false
		var killer_col = $Gimmicks/MarioGroup/Hitbox
		killer_col.disabled = true
		killer_col.position = Vector2(-1000, -1000)
		
		var _tween = create_tween()
		
		_tween.tween_property(mario_itself,"modulate",Color.TRANSPARENT,1.0)
		mario_got_hit = true

