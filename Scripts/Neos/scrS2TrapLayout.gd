extends Node2D

@export var trigger_id: int = 0

var triggered: bool = false
var block_position_jail = Vector2(144, 48)

@onready var obj_invisible_block = $objInvisibleBlock
@onready var label = $Label

# Called when the node enters the scene tree for the first time.
func _ready():
	label.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GLOBAL_GAME.triggered_events.has(trigger_id) and !triggered:
		obj_invisible_block.position = block_position_jail
		label.visible = true
		triggered = true
