extends CharacterBody2D

class_name Ball

@export var ball_speed = 20

func _ready():
	start_ball()
	

func _physics_process(delta):
	var collision = move_and_collide(velocity * ball_speed * delta)
	
	if(collision):
		velocity = velocity.bounce(collision.get_normal())

func start_ball():
	randomize()
	
	velocity.x = [-.8, .8][randi() % 2] * ball_speed
	velocity.y = [-1, 1][randi() % 2] * ball_speed
