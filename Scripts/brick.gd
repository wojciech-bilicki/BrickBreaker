extends RigidBody2D

class_name Brick

@onready var collision_shape_2d = $CollisionShape2D

func get_size():
	return collision_shape_2d.shape.get_rect().size
	
