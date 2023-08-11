extends CharacterBody2D

class_name Ball

@export var ball_speed = 20

var last_collider_id

func _ready():
	start_ball()
	

func _physics_process(delta):
	var collision = move_and_collide(velocity * ball_speed * delta)
	
	if(collision):
		var collider = collision.get_collider()
		var collider_id = collision.get_collider_id()
		if collider is Brick:
			if last_collider_id == collider.id:
				velocity = velocity.bounce(collision.get_normal() + Vector2(randi_range(0, 1), randi_range(0, 1)))
				collider.decrease_level()

func start_ball():
	randomize()
	
	velocity.x = [-.8, .8][randi() % 2] * ball_speed
	velocity.y = [-1, 1][randi() % 2] * ball_speed
