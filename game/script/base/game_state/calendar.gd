extends Node


signal day_finished
signal next_day_started


var _current_date: int = Time.get_unix_time_from_datetime_string("2023-01-01")
var _day_value_in_unix_timestamp: int = 24 * 60 * 60


func start_next_day() -> void:
	emit_signal("day_finished")
	_current_date += _day_value_in_unix_timestamp
	emit_signal("next_day_started")


func get_current_date() -> String:
	return Time.get_date_string_from_unix_time(_current_date)
