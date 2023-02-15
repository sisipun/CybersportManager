extends Control


export (NodePath) onready var _next_day_button = get_node(_next_day_button) as Button
export (NodePath) onready var _day_number_label = get_node(_day_number_label) as Label


func _ready():
	_day_number_label.text = str(WorldState.day_number)
	
	assert(WorldState.connect("next_day_started", self, "_on_next_day_started") == OK)
	assert(_next_day_button.connect("pressed", self, "_on_next_day_button_pressed") == OK)


func _on_next_day_started() -> void:
	_day_number_label.text = str(WorldState.day_number)


func _on_next_day_button_pressed() -> void:
	WorldState.start_next_day()
