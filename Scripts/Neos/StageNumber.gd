extends Control

@onready var stage_group = [$Stage1, $Stage2, $Stage3, $Stage4, $Stage5]
@onready var time_transition = $TimeTransition

var next_room: String
var current_number_stage: int

# Called when the node enters the scene tree for the first time.
func _ready():
	# Get values from the GLOBAL_GAME vars
	next_room = GLOBAL_GAME.next_room_transition
	current_number_stage = GLOBAL_GAME.next_room_transition_number
	
	# Get length of the array
	var _total_stages = stage_group.size()
	# Hide every group of nodes in the array of group nodes
	for i in _total_stages:
		stage_group[i].hide()
		
	# Show the group node we want to travel
	stage_group[current_number_stage].show()
	# Timer to transition
	time_transition.start()


func _on_time_transition_timeout():
	get_tree().change_scene_to_file(next_room)
