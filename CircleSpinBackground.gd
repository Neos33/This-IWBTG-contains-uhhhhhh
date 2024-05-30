@tool
extends Node2D

@export var radius_circle = Vector2(64, 32)
@export var speed_angle = 1
@export_range(1, 10, 1) var number_of_circles : int = 6
@export var circle_size = Vector2(100, 100)


@onready var ellipse = [$Ellipse, $Ellipse2, $Ellipse3, $Ellipse4, $Ellipse5, $Ellipse6, $Ellipse7, $Ellipse8, $Ellipse9, $Ellipse10]

var angle = 0
var total = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var _total = number_of_circles
	var _x
	var _y
	for i in _total:
		_x = radius_circle.x * cos(deg_to_rad(360 / _total * i + angle))
		_y = radius_circle.y * sin(deg_to_rad(360 / _total * i + angle))
		
		ellipse[i].size = circle_size
		ellipse[i].position.x = _x
		ellipse[i].position.y = _y
		
	angle += speed_angle * delta
