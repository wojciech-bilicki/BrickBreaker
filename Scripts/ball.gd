extends CharacterBody2D

class_name Ball

@export var ball_speed = 20
@export var death_zone: DeathZone
@export var ui: UI
@export var lifes: int = 3

@onready var collision_shape_2d = $CollisionShape2D

var start_position: Vector2
var last_collider_id

func _ready():
	ui.set_lifes(lifes)
	start_position = position
	death_zone.lose_life.connect(on_life_lost)
	start_ball()
	
func _physics_process(delta):
	var collision = move_and_collide(velocity * ball_speed * delta )
	
	if(collision):
		var collider = collision.get_collider()
		if collider is Brick:
			collider.decrease_level()
			
		if (collider is Brick or collider is Paddle):
			ball_collision(collider)
		
		

		else:
			velocity = velocity.bounce(collision.get_normal())
		
#		var collider_id = collision.get_collider_id()
#		if collider is Brick:
#			if last_collider_id == collider.get_rid():
#				velocity = velocity.bounce(collision.get_normal())
#			else: 
#				velocity = velocity.bounce(collision.get_normal())
#				last_collider_id = collider.get_rid()
#			collider.decrease_level()
#		else:
#			
			
func start_ball():
	print_debug("START BALL")
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
	
func ball_collision(collider):
	
	var ball_width = collision_shape_2d.shape.get_rect().size.x
	var ball_center_x = position.x
	var collider_width = collider.get_width()
	var collider_center_x = collider.position.x 
	
	var velocity_xy = velocity.length()
	
#	 // Calculate the position of the ball relative to the center of
#	// the paddle, and express this as a number between -1 and +1.
#	// (Note: collisions at the ends of the paddle may exceed this
#	// range, but that is fine.)
	var collision_x = (ball_center_x - collider_center_x) / (collider_width / 2)
	
	var new_velocity = Vector2(0,0)
	
#	   // Let the new X speed be proportional to the ball position on
#	// the paddle.  Also make it relative to the original speed and
#	// limit it by the influence factor defined above.
	new_velocity.x = velocity_xy * collision_x
	
	
# // Finally, based on the new X speed, calculate the new Y speed
#    // such that the new overall speed is the same as the old.  This
#    // is another application of the Pythagorean theorem.  The new
#    // Y speed will always be nonzero as long as the X speed is less
#    // than the original overall speed.
	new_velocity.y = sqrt(velocity_xy*velocity_xy - new_velocity.x*new_velocity.x) * -1 if velocity.y > 0 else 1 * ball_speed
	velocity = new_velocity
