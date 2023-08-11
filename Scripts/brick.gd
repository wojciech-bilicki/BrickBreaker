extends RigidBody2D

class_name Brick

@export var level: int = 1

@onready var collision_shape_2d = $CollisionShape2D
@onready var sprite_2d = $Sprite2D as Sprite2D

var sprites: Array[Texture2D] = [
	preload("res://Assets/Brick-Yellow.png"), 
	preload("res://Assets/Brick-Blue.png"),
	preload("res://Assets/Brick-Orange.png"),
	preload("res://Assets/Brick-Green.png"),
	preload("res://Assets/Brick-Gray.png"),
	preload("res://Assets/Brick-Red.png")
	]

func get_size():
	return collision_shape_2d.shape.get_rect().size
	

func set_level(new_level: int):
	level = new_level
	sprite_2d.texture = sprites[new_level - 1]


func _on_body_entered(body):
	print(body)
	if body is Ball:
		print("Ball")

func decrease_level():
	if level > 1:
		set_level(level - 1)
	else:
		fade_out();

func fade_out():
	var tween = get_tree().create_tween()
	tween.tween_property(sprite_2d, "modulate", Color.TRANSPARENT, .5)
	tween.tween_callback(queue_free)
	



