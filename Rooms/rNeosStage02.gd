extends Node2D

var loop_position: float

# Called when the node enters the scene tree for the first time.
func _ready():
	loop_position = randf_range(20.317, 26.765)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Music restarting
	if GLOBAL_MUSIC.get_playback_position() > loop_position:
		GLOBAL_MUSIC.seek(0.3)
		loop_position = randf_range(20.317, 26.765)
