extends CanvasLayer

class_name UI

@onready var label = %Label
@onready var button = %Button
@onready var center_container = $MarginContainer/CenterContainer


func set_lifes(lifes: int):
	label.text = "Lifes: %d" % lifes

func game_over():
	center_container.show()
	
func _on_button_pressed():
	get_tree().reload_current_scene()
