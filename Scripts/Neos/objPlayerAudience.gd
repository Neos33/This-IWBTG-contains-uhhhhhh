extends Node2D

@onready var shirt_mask = $Body/ShirtMask
@onready var animation_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	shirt_mask.modulate = Color(randf(), randf(), randf())
	animation_player.play("UpDown", -1, randf_range(1.5, 2.0))
	animation_player.seek(randf())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
