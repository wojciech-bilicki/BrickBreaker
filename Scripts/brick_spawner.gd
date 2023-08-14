extends Node

const COLUMNS = 5
const ROWS = 6

@export var brick_scene: PackedScene 
@export var margin: Vector2 = Vector2(8, 8)
@export var spawn_start: Marker2D

func _ready():
	spawn_from_defintion()
	
func spawn():
	var test_brick = brick_scene.instantiate() as Brick
	add_child(test_brick)

	var brick_size = test_brick.get_size() * .25
	test_brick.queue_free()

	var row_width = brick_size.x * COLUMNS + margin.x * (COLUMNS - 1)
	var spawn_position = - row_width /2 + brick_size.x/2 + margin.x/ 2
	print_debug(spawn_position)
	
	for j in ROWS:
		for i in COLUMNS:
			var brick = brick_scene.instantiate() as Brick
			brick.scale = Vector2(0.25, 0.25)
			add_child(brick)
			brick.set_level(ROWS - j)
			var x = spawn_position + i * (margin.x + brick.get_size().x * brick.scale.x) 
			var y = spawn_start.position.y + j * (margin.y + brick.get_size().y * brick.scale.y)
			brick.set_position(Vector2(x, y))

func spawn_from_defintion():
	var defintion = LevelDefinitions.level_2 if LevelDefinitions.current_level == 1 else LevelDefinitions.level_1
	
	var test_brick = brick_scene.instantiate() as Brick
	add_child(test_brick)

	var brick_size = test_brick.get_size() * .25
	test_brick.queue_free()
	
	var rows = defintion.size()
	var columns = defintion[0].size()

	print_debug(rows)
	print_debug(columns)
	var row_width = brick_size.x * columns + margin.x * (columns - 1)
	print_debug(row_width)
	var spawn_position = - row_width /2 


	for j in rows:
		for i in columns:
			if defintion[j][i] == 0:
				continue
			
			var brick = brick_scene.instantiate() as Brick
			brick.scale *= 0.25
			add_child(brick)
			brick.set_level(defintion[j][i])
			var x = spawn_position + i * (margin.x + brick.get_size().x * brick.scale.x) 
			var y = spawn_start.position.y + j * (margin.y + brick.get_size().y * brick.scale.y)
			brick.set_position(Vector2(x, y)) 
	
	
