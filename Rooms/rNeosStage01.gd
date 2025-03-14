extends Node2D

@onready var obj_camera_fixed = $Room_related/objCameraFixed
@onready var obj_lancia = $objLancia
@onready var race_countdown = $Trigger_related/RaceCountdown

var lancia_won: bool = false
const kid_audience_offset: int = 28
const kid_audience_total: int = 16
var kid_lucky

# Called when the node enters the scene tree for the first time.
func _ready():
	# Make one of the audience be upside down
	kid_lucky = get_node("Room_related/Audience/objPlayerAudience" + str(randi_range(1, kid_audience_total)))
	kid_lucky.rotation = 3.15 # idk why 3.15 to rotate 180 degrees
	kid_lucky.scale.x = -1
	kid_lucky.position.y -= kid_audience_offset
	race_countdown.target_instance_zoom = kid_lucky
	if GLOBAL_GAME.autosave_after_transition:
		GLOBAL_SAVELOAD.save_game(true)
		GLOBAL_GAME.autosave_after_transition = false
		print("Game saved!")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_instance_valid(obj_lancia):
		obj_lancia.position.x = min(obj_lancia.position.x, 4104)
		if obj_lancia.position.x == 4104 and !lancia_won:
			lancia_won = true
			obj_lancia.update_text("You lose", Vector2(-64, 0))
			
	


# Game freeze and focus to whatever node I selected in the export variable of RaceCountdown
func _on_race_countdown_change_camera_focus():
	obj_camera_fixed.enabled = false


# Animation player ended, camera back to normal behaviour
func _on_race_countdown_counter_finished():
	obj_camera_fixed.enabled = true


# Race GO!, car move and unfreeze the player
func _on_race_countdown_race_started():
	obj_lancia.start_moving = true
	GLOBAL_INSTANCES.objPlayerID.frozen = false
