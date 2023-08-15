extends RigidBody2D

class_name Paddle
var direction = Vector2.ZERO

@export var speed = 200
@export var camera: Camera2D

var half_paddle_width
var camera_rect: Rect2
@onready var collision_shape_2d = $CollisionShape2D
@onready var ball = $"../Ball" as Ball 
var is_ball_started = false
var start_position

# Called when the node enters the scene tree for the first time.
func _ready():
	ball.life_lost.connect(on_ball_lost)
	camera_rect = camera.get_viewport_rect()
	half_paddle_width = collision_shape_2d.shape.get_rect().size.x / 2 * scale.x
	
func _physics_process(delta):
	linear_velocity = speed  * direction

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var camera_start_x = camera.position.x - camera_rect.size.x / 2
	var camera_end_x = camera_start_x + camera_rect.size.x
	if global_position.x - half_paddle_width < camera_start_x:
		self.global_position.x = camera_start_x + half_paddle_width
	elif global_position.x + half_paddle_width > camera_end_x:
		self.global_position.x = camera_end_x - half_paddle_width
	

func _input(event):
	if Input.is_action_pressed("left"):
		direction = Vector2.LEFT
	elif Input.is_action_pressed("right"):
		direction = Vector2.RIGHT
	else:
		direction = Vector2.ZERO
	
	if direction != Vector2.ZERO && !is_ball_started:
		ball.start_ball()
		is_ball_started = true

func get_width():
	return collision_shape_2d.shape.get_rect().size.x

func on_ball_lost():
	is_ball_started = false
	direction = Vector2.ZERO
