extends Area2D

class_name DeathZone

signal lose_life

func _on_body_entered(body):
	lose_life.emit()
