extends Node


signal day_finished
signal next_day_started


var day_number: int = 0


func _ready():
	day_number = 0


func start_next_day() -> void:
	emit_signal("day_finished")
	day_number += 1
	emit_signal("next_day_started")
