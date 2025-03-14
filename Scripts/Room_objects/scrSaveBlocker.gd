extends StaticBody2D

var sprite_alpha: float = 0.0
var activate_visual: bool = false
var fade_amount: float = 0.1



# Makes the sprite invisible at startup
func _ready():
	modulate.a = sprite_alpha


# Fades the sprite alpha
func _physics_process(delta):
	
	modulate.a = sprite_alpha
	
	if (activate_visual == true):
		sprite_alpha -= GLOBAL_GAME.frame_to_delta(fade_amount, delta)
		
		if sprite_alpha <= 0:
			sprite_alpha = 0
			activate_visual = false


# Method called from bullets/attacks
func react_to_hit(_attack_type, _attack_damage):
	if (activate_visual == false):
		return # Cancel all the flashy and sfx stuff
		sprite_alpha = 1
		GLOBAL_SOUNDS.play_sound(GLOBAL_SOUNDS.sndSaveBlocker)
		activate_visual = true
