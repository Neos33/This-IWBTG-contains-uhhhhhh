extends Node2D

@export var trigger_id: int = 0
@export var target_position: Vector2 = Vector2(0, 0)

var triggered: bool = false
var start_position: Vector2 = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	start_position = position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GLOBAL_GAME.triggered_events.has(trigger_id) and !triggered:
		triggered = true
		var _tween = create_tween()
		_tween.tween_property(self, "position", start_position + target_position, 2.0)
