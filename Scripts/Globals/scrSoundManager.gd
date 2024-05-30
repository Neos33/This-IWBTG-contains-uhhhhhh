extends Node


# Add sound effects here!
const sndDeath = preload("res://Audio/Sounds/sndDeath.wav")
const sndDJump = preload("res://Audio/Sounds/sndDJump.wav")
const sndJump = preload("res://Audio/Sounds/sndJump.wav")
const sndShoot = preload("res://Audio/Sounds/sndShoot.wav")
const sndJumpRefresher = preload("res://Audio/Sounds/sndJumpRefresher.wav")
const sndMenuButton = preload("res://Audio/Sounds/sndMenuButton.wav")
const sndSave = preload("res://Audio/Sounds/sndSave.wav")
const sndSaveBlocker = preload("res://Audio/Sounds/sndSaveBlocker.wav")
const sndPause = preload("res://Audio/Sounds/sndPause.wav")
const sndHit = preload("res://Audio/Sounds/sndHit.wav")
const sndCherry = preload("res://Audio/Sounds/sndCherry.wav")
const sndCoin = preload("res://Audio/Sounds/sndCoin.wav")
const sndItem = preload("res://Audio/Sounds/sndItem.wav")
const sndWarp = preload("res://Audio/Sounds/sndWarp.wav")
const sndBlockChange = preload("res://Audio/Sounds/sndBlockChange.wav")
const sndSheepBlock = preload("res://Audio/Sounds/sndSheepBlock.wav")
const sndBouncyBlock = preload("res://Audio/Sounds/sndBouncyBlock.wav")
const sndSpikeBlock = preload("res://Audio/Sounds/sndSpikeBlock.wav")

# My SFXs


# We get the audioPlayerList node from this variable. A little cleaner
@onready var audioPlayers: Node = $audioPlayerList



# Sound should keep on playing/processing even if the game is paused
func _ready():
	process_mode = PROCESS_MODE_ALWAYS



## Loop through the 8 [AudioStreamPlayer]s and assigns the given sound
## to the first available bus.
func play_sound(sound) -> void:
	var _total_audio_players = audioPlayers.get_children()
	for audioStreamPlayers in _total_audio_players:
		if not audioStreamPlayers.playing:
			audioStreamPlayers.stream = sound
			audioStreamPlayers.play()
			break


## Loop through the 8 [AudioStreamPlayer]s to find the one assigned
## the given sound, and stops it from playing.
func stop_sound(sound) -> void:
	var _total_audio_players = audioPlayers.get_children()
	for audioStreamPlayers in _total_audio_players:
		if audioStreamPlayers.get_stream() == sound:
			audioStreamPlayers.stop()
	
