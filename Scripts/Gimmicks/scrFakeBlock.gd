extends Node2D

@onready var sprite_2d = $Sprite2D
@onready var collision_shape_2d = $Detection/CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func disable_behaivour(mode: bool):
	sprite_2d.visible = !mode
	collision_shape_2d.disabled = mode

func _on_detection_body_entered(body):
	GLOBAL_SOUNDS.play_sound(GLOBAL_SOUNDS.sndBlockChange)
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_entered():
	disable_behaivour(false)


func _on_visible_on_screen_notifier_2d_screen_exited():
	disable_behaivour(true)
