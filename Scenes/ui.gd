extends CanvasLayer

class_name UI

@onready var label = %Label
@onready var button = %Button
@onready var game_lost_container = %GameLostContainer
@onready var level_won_container = %LevelWonContainer


func set_lifes(lifes: int):
	label.text = "Lifes: %d" % lifes

func game_over():
	game_lost_container.show()
	
func _on_button_pressed():
	get_tree().reload_current_scene()

func on_level_won():
	level_won_container.show()

func _on_level_won_button_pressed():
	LevelDefinitions.current_level = 2
	get_tree().reload_current_scene()
