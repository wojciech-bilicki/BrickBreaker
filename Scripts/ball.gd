extends CharacterBody2D

class_name Ball

@export var ball_speed = 20
@export var death_zone: DeathZone
@export var ui: UI
@export var lifes: int = 3

var start_position: Vector2
var last_collider_id

func _ready():
	ui.set_lifes(lifes)
	start_position = position
	death_zone.lose_life.connect(on_life_lost)
	start_ball()
	
func _physics_process(delta):
	var collision = move_and_collide(velocity * ball_speed * delta)
	
	if(collision):
		var collider = collision.get_collider()
		var collider_id = collision.get_collider_id()
		if collider is Brick:
			if last_collider_id == collider.get_rid():
				velocity = velocity.bounce(collision.get_normal())
			else: 
				velocity = velocity.bounce(collision.get_normal())
				last_collider_id = collider.get_rid()
			collider.decrease_level()
		else:
			velocity = velocity.bounce(collision.get_normal())
			
func start_ball():
	position = start_position
	randomize()
	
	velocity.x = [-.8, .8][randi() % 2] * ball_speed
	velocity.y = [-1, 1][randi() % 2] * ball_speed

func on_life_lost():
	lifes -= 1
	if lifes == 0:
		game_over()	
	else:
		ui.set_lifes(lifes)
		start_ball()

func game_over():
	position = start_position
	velocity = Vector2.ZERO
	ui.game_over()
	
