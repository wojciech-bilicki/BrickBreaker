extends Node

const COLUMNS = 6
const ROWS = 6

@export var brick_scene: PackedScene 
@export var margin: Vector2 = Vector2(8, 8)
@export var spawn_start: Marker2D

func _ready():
	for j in ROWS:
		for i in COLUMNS:
			var brick = brick_scene.instantiate() as Brick
			brick.scale = Vector2(0.25, 0.25)
			add_child(brick)
			brick.set_level(ROWS - j)
			var x = spawn_start.position.x + i * (margin.x + brick.get_size().x * brick.scale.x) 
			var y = spawn_start.position.y + j * (margin.y + brick.get_size().y * brick.scale.y)
			brick.set_position(Vector2(x, y))
