extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if GLOBAL_GAME.autosave_after_transition:
		GLOBAL_SAVELOAD.save_game(true)
		GLOBAL_GAME.autosave_after_transition = false
		print("Game saved!")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
